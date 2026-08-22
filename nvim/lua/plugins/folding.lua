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
    return ok and tagged or ranges
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
      -- Returning nil keeps ufo's default {'lsp', 'indent'} pair.
      provider_selector = function(_, filetype, _)
        if decl_queries[filetype] then
          return { lsp_with_declarations, 'indent' }
        end
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

    vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
    vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds, { desc = 'Fold less' })
    vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith, { desc = 'Fold more' })
    vim.keymap.set('n', 'zp', require('ufo').peekFoldedLinesUnderCursor, { desc = 'Peek fold' })
  end,
}
