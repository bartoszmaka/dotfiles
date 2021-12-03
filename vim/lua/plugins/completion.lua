local config_helper = require('config_helper')
local symbol_map = require("lsp/symbol_map")
local cmp = require'cmp'
local compare = require('cmp.config.compare')

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
  max_lines = 1000;
  max_num_results = 5;
  sort = true;
	run_on_every_keystroke = true;
	snippet_placeholder = '..';
})

cmp.setup({
  preselect = cmp.PreselectMode.None,
  completion = {
    -- completeopt = 'menu,menuone,noinsert',
  },
  sources = {
    { name = "ultisnips" },
    { name = 'nvim_lsp' },
    { name = 'path' },
    -- { name = 'cmp_tabnine' },
    { name = 'buffer', get_bufnrs = function() return vim.api.nvim_list_bufs() end },
    { name = 'spell' },
    { name = 'nvim_lsp_document_symbol' },
    -- { name = 'rg' },
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
  -- documentation = {
  --   border = 'single',
  --   winhighlight = 'FloatBorder:FloatBorder,Normal:Normal',
  -- },
  experimental = {
    ghost_text = true,
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = (symbol_map[vim_item.kind] or "") .. " " .. vim_item.kind
      vim_item.menu = ({
        buffer = "[Buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        omni = "[Omni]",
        ultisnips = "[Snip]",
        spell = "[Spell]",
        cmp_tabnine = "[TN]",
        rg = "[rg]"
      })[entry.source.name] or entry.source.name
      return vim_item
    end,
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
    \    { name = 'buffer',
    \      get_bufnrs = function()
    \        local bufs = {}
    \        for _, win in ipairs(vim.api.nvim_list_wins()) do
    \          bufs[vim.api.nvim_win_get_buf(win)] = true
    \        end
    \        return vim.tbl_keys(bufs)
    \      end},
    \    { name = 'spell' },
    \  },
    \ }
  augroup END
]]
