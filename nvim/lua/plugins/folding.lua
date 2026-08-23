-- The LSP folding-range protocol only defines three kinds -- `comment`,
-- `imports` and `region` -- which is too coarse for what we want to auto-close:
--
--   * TypeScript: vtsls returns interfaces and type aliases with NO kind at all
--     (verified: `export interface Foo {` and `export type Bar = {` come back as
--     kind=nil), so ufo's close_fold_kinds can never target them.
--   * Ruby: ruby-lsp tags every class, module, `def` and `do` block as `region`
--     alike, so closing `region` would collapse whole classes, not method bodies.
--
-- Rather than re-implement fold closing on a timer, wrap the LSP provider and
-- re-tag just those ranges with a private kind. ufo's own close_fold_kinds
-- machinery then closes them at exactly the right moment, with its existing
-- cursor-line and first-apply handling intact.
--
-- (`comment` and `imports` already work through the stock kinds for both
-- languages -- multiline comments were folding before this.)
local DECL_KIND = 'declaration'

-- Node types whose fold should start closed, per filetype. Their treesitter
-- start row lines up exactly with the LSP range's startLine, including when
-- wrapped in `export ...`, so matching on start row is enough.
local TS_DECLS = [[
  (interface_declaration) @decl
  (type_alias_declaration) @decl
]]

-- `left: (constant)` is what keeps this to constants: a multiline `local_var = {`
-- is an assignment too, but its left side is an (identifier) and stays open.
local RUBY_DECLS = [[
  (method) @decl
  (singleton_method) @decl
  (assignment left: (constant)) @decl
]]

local decl_queries = {
  typescript      = TS_DECLS,
  typescriptreact = TS_DECLS,
  ruby            = RUBY_DECLS,
}

---Start rows (0-indexed) of every node we want folded shut in this buffer.
local function declaration_start_rows(bufnr)
  local filetype = vim.bo[bufnr].filetype
  local query_src = decl_queries[filetype]
  if not query_src then
    return nil
  end

  local lang = vim.treesitter.language.get_lang(filetype)
  if not lang then
    return nil
  end

  local ok, parser = pcall(vim.treesitter.get_parser, bufnr, lang)
  if not ok or not parser then
    return nil
  end

  local ok_query, query = pcall(vim.treesitter.query.parse, lang, query_src)
  if not ok_query then
    return nil
  end

  local trees = parser:parse()
  if not trees or not trees[1] then
    return nil
  end

  local rows = {}
  for _, node in query:iter_captures(trees[1]:root(), bufnr) do
    rows[node:start()] = true
  end
  return rows
end

-- ruby-lsp (and every other server tried here) ends a folding range on the line
-- *before* the construct's own closing delimiter, so a two-line method folds to
-- two lines -- `def foo(...) ...` with a lonely `end` underneath. Treesitter
-- knows where that delimiter is: it is the final row of the node that opens on
-- the range's start row.
--
-- Keyed by start row -> set of end rows, rather than "the largest end row for
-- this row", because several nodes begin on the same row and some end at column
-- 0 of a *later* line (`program` on row 0 of a file ending in a newline). Only an
-- exact hit on `endLine + 1` may extend a fold.
local function node_end_rows(bufnr)
  local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
  if not lang then
    return nil
  end

  local ok, parser = pcall(vim.treesitter.get_parser, bufnr, lang)
  if not ok or not parser then
    return nil
  end

  local trees = parser:parse()
  if not trees or not trees[1] then
    return nil
  end

  local rows = {}
  local stack = { trees[1]:root() }
  while #stack > 0 do
    local node = table.remove(stack)
    local start_row = node:start()
    local end_row = node:end_()
    local at_row = rows[start_row]
    if not at_row then
      at_row = {}
      rows[start_row] = at_row
    end
    at_row[end_row] = true
    for child in node:iter_children() do
      stack[#stack + 1] = child
    end
  end
  return rows
end

-- Pull each fold down over its own closing delimiter, so the construct collapses
-- to a single line. Only applied when a node starting on the fold's first line
-- ends exactly one line past the fold -- which is what a bare `end` / `}` is.
-- A multiline comment's node ends on the range's own last line, not one past it,
-- so comment and import folds are left alone.
local function absorb_closing_delimiter(bufnr, ranges)
  if not ranges then
    return ranges
  end

  local rows = node_end_rows(bufnr)
  if not rows then
    return ranges
  end

  for _, range in ipairs(ranges) do
    local at_row = rows[range.startLine]
    if at_row and at_row[range.endLine + 1] then
      range.endLine = range.endLine + 1
    end
  end
  return ranges
end

local function tag_declarations(bufnr, ranges)
  if not ranges then
    return ranges
  end

  local rows = declaration_start_rows(bufnr)
  if not rows then
    return ranges
  end

  for _, range in ipairs(ranges) do
    if rows[range.startLine] then
      range.kind = DECL_KIND
    end
  end
  return ranges
end

-- Same as the stock 'lsp' provider, only with the extra kind attached. A
-- rejection (no LSP client / UfoFallbackException) propagates untouched so
-- ufo still falls back to the indent provider.
local function lsp_with_declarations(bufnr)
  return require('ufo.provider.lsp').getFolds(bufnr):thenCall(function(ranges)
    local ok, tagged = pcall(tag_declarations, bufnr, ranges)
    ranges = ok and tagged or ranges
    local ok_absorb, absorbed = pcall(absorb_closing_delimiter, bufnr, ranges)
    return ok_absorb and absorbed or ranges
  end)
end

local function with_declarations(kinds)
  local list = vim.deepcopy(kinds)
  table.insert(list, DECL_KIND)
  return list
end

local BASE_KINDS = { 'imports', 'comment' }

return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  config = function()
    require('ufo').setup({
      -- Every filetype goes through the wrapper: single-line folding applies to
      -- anything treesitter can parse, while the declaration tagging below stays
      -- scoped to `decl_queries` (it no-ops for filetypes not listed there).
      -- Without a parser both passes leave the ranges untouched, which is the
      -- stock 'lsp' provider's behaviour.
      provider_selector = function(_, _, _)
        return { lsp_with_declarations, 'indent' }
      end,
      -- NB: a filetype entry replaces `default` outright, it does not extend it,
      -- so the base kinds have to be repeated.
      close_fold_kinds_for_ft = {
        default = BASE_KINDS,
        typescript = with_declarations(BASE_KINDS),
        typescriptreact = with_declarations(BASE_KINDS),
        ruby = with_declarations(BASE_KINDS),
        json = {},
        c = { 'comment', 'region' },
      },
      close_fold_current_line_for_ft = {
        default = true,
        c = false,
      },
    })

    -- ufo asks the LSP for folding ranges once, roughly two seconds after a
    -- buffer opens, and never asks again -- it registers no LspAttach handler of
    -- its own. ruby-lsp resolves the bundle and builds its index before it
    -- answers anything, so on a real project it attaches long after that single
    -- request has already failed, leaving ufo on the `indent` fallback. The
    -- indent provider reports no fold `kind`, so close_fold_kinds_for_ft has
    -- nothing to act on and nothing auto-closes.
    --
    -- ufo also latches the failure: five rejections for a filetype inside 120s
    -- set hasProviders[ft] = false, disabling LSP folds for that filetype for the
    -- rest of the session. providerContext holds the timestamp/count behind that
    -- latch, so both have to be cleared or the next request re-latches at once.
    --
    -- When a fold-capable client finally attaches, clear the latch and re-attach
    -- the buffer so the request runs again -- which also re-runs ufo's
    -- first-apply fold closing.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('ufo_refold_on_lsp_attach', { clear = true }),
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client or not client.server_capabilities.foldingRangeProvider then
          return
        end

        local bufnr = args.buf
        -- Once per buffer: on a filetype with several fold-capable clients this
        -- would otherwise cycle per attach, and a re-attach re-closes folds --
        -- unwanted once the user has opened some by hand.
        if vim.b[bufnr].ufo_lsp_refolded then
          return
        end

        vim.schedule(function()
          if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].buftype ~= '' then
            return
          end
          vim.b[bufnr].ufo_lsp_refolded = true

          local ft = vim.bo[bufnr].filetype
          pcall(function()
            local lsp_provider = require('ufo.provider.lsp')
            lsp_provider.hasProviders[ft] = nil
            lsp_provider.providerContext[ft] = nil
          end)

          local ok, ufo = pcall(require, 'ufo')
          if not ok then
            return
          end
          if ufo.hasAttached(bufnr) then
            ufo.detach(bufnr)
          end
          ufo.attach(bufnr)
        end)
      end,
    })

    vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
    vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds, { desc = 'Fold less' })
    vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith, { desc = 'Fold more' })
    vim.keymap.set('n', 'zp', require('ufo').peekFoldedLinesUnderCursor, { desc = 'Peek fold' })
  end,
}
