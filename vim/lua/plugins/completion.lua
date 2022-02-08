local config_helper = require('config_helper')
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
local tabnine = require('cmp_tabnine.config')
tabnine:setup({
	-- max_lines = 1000;
	-- max_num_results = 20;
	-- sort = true;
	-- run_on_every_keystroke = true;
	-- snippet_placeholder = '..';
	-- ignored_file_types = { -- default is not to ignore
	-- 	-- uncomment to ignore in lua:
	-- 	-- lua = true
	-- };
})

cmp.setup({
  preselect = cmp.PreselectMode.None,
  completion = {
  },
  sources = {
    { name = 'copilot' },
    { name = "ultisnips" },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer', get_bufnrs = function() return vim.api.nvim_list_bufs() end },
    { name = 'spell' },
    { name = 'nvim_lsp_document_symbol' },
    { name = 'cmp_tabnine' },
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      compare.offset,
      compare.exact,
      compare.score,
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
\    { name = 'copilot' },
\  },
\ }
augroup END
]]
