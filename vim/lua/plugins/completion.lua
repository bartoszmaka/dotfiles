local cmp = require('cmp')
local compare = require('cmp.config.compare')
local lspkind = require('lspkind')

vim.cmd[[
  set pumheight=10
]]

local is_prior_char_whitespace = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Custom sorting/ranking for completion items.
local cmp_helper = {}
cmp_helper.compare = {
  -- Deprioritize items starting with underscores (private or protected)
  deprioritize_underscore = function(lhs, rhs)
    local l = (lhs.completion_item.label:find "^_+") and 1 or 0
    local r = (rhs.completion_item.label:find "^_+") and 1 or 0
    if l ~= r then return l < r end
  end,
  -- Prioritize items that ends with "= ..." (usually for argument completion).
  prioritize_argument = function(lhs, rhs)
    local l = (lhs.completion_item.label:find "=$") and 1 or 0
    local r = (rhs.completion_item.label:find "=$") and 1 or 0
    if l ~= r then return l > r end
  end,
}

-- local tabnine = require('cmp_tabnine.config')
-- tabnine:setup({
-- 	max_lines = 1000;
-- 	max_num_results = 20;
-- 	sort = true;
-- 	run_on_every_keystroke = true;
-- 	snippet_placeholder = '..';
-- 	ignored_file_types = { -- default is not to ignore
-- 		-- uncomment to ignore in lua:
-- 		-- lua = true
-- 	};
-- 	show_prediction_strength = false;
-- })

cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  preselect = cmp.PreselectMode.None,
  completion = {},
  sources = {
    { name = 'nvim_lsp_signature_help' },
    -- { name = 'cmp_tabnine', priority = 95 },
    -- { name = 'copilot', priority = 100 },
    { name = 'ultisnips', priority = 99 },
    { name = 'nvim_lsp', priority = 98 },
    { name = 'path', priority = 97},
    { name = 'buffer', priority = 96, options = {
      keyword_pattern = [[\k\+]],
      get_bufnrs = function()
        return vim.api.nvim_list_bufs()
      end,
    } },
    -- { name = 'cmp_tabnine', priority = 90 },
    { name = 'spell' },
    { name = 'nvim_lsp_document_symbol' },
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      -- require('cmp_tabnine.compare'),
      compare.offset,
      compare.exact,
      compare.score,
      function(...) return cmp_helper.compare.prioritize_argument(...) end,
      function(...) return cmp_helper.compare.deprioritize_underscore(...) end,
      compare.recently_used,
      compare.kind,
      compare.sort_text,
      compare.length,
      compare.order,
    }
  },
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    ['<C-j>'] = cmp.mapping.complete(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if vim.fn.complete_info()["selected"] == -1 and vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
        vim.fn.feedkeys(t("<C-R>=UltiSnips#ExpandSnippet()<CR>"))
      elseif cmp.visible() then
        cmp.select_next_item()
      elseif is_prior_char_whitespace() then
        vim.fn.feedkeys(t("<tab>"), "n")
      else
        fallback()
      end
    end, {
        "i",
        "s",
      }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
        return vim.fn.feedkeys(t("<C-R>=UltiSnips#JumpBackwards()<CR>"))
      elseif cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, {
        "i",
        "s",
      }),
    ['<CR>'] = cmp.mapping.confirm()
  },
  experimental = {
    ghost_text = true,
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      menu = ({
        buffer = "[Buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        omni = "[Omni]",
        ultisnips = "[Snip]",
        spell = "[Spell]",
        cmp_tabnine = "[TN]",
        copilot = "[AI]",
      })
    }),
  },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline([[/\V]], {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

vim.cmd[[
augroup cmp_config
autocmd!

autocmd FileType css,scss,sass lua require'cmp'.setup.buffer {
\  sources = {
\    { name = "ultisnips" },
\    { name = 'nvim_lsp' },
\    { name = 'omni' },
\    { name = 'path' },
\    { name = 'buffer', get_bufnrs = function() return vim.api.nvim_list_bufs() end },
\    { name = 'spell' },
\  },
\ }
augroup END
]]
