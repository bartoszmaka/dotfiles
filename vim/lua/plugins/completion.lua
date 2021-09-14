local config_helper = require('config_helper')
local imap = config_helper.imap
local smap = config_helper.smap
local symbol_map = require("lsp/symbol_map")

vim.cmd[[
  augroup setup_snippet_aliases
    autocmd!
  
    autocmd FileType javascript UltiSnipsAddFiletypes javascriptreact
    autocmd FileType typescript UltiSnipsAddFiletypes javascript.javascriptreact
    autocmd FileType javascriptreact UltiSnipsAddFiletypes javascript
    autocmd FileType typescriptreact UltiSnipsAddFiletypes javascript.typescript.javascriptreact
    autocmd FileType javascript.jsx UltiSnipsAddFiletypes javascript.javascriptreact.javascript.jsx
    autocmd FileType typescript.tsx UltiSnipsAddFiletypes javascript.typescript.javascriptreact.javascript.jsx
  augroup END
]]

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
})

local cmp = require'cmp'
local compare = require('cmp.config.compare')

cmp.setup({
  sources = {
    { name = "ultisnips" },
    { name = 'cmp_tabnine' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer',
      get_bufnrs = function()
        local bufs = {}
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          bufs[vim.api.nvim_win_get_buf(win)] = true
        end
        return vim.tbl_keys(bufs)
      end},
    { name = 'spell' },
    {
      name = 'tmux',
      opts = {
        all_panes = true,
        label = '[tmux]'
      }
    }
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
    ["<C-Space>"] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
        if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
          return vim.fn.feedkeys(t("<C-R>=UltiSnips#ExpandSnippet()<CR>"))
        end

        vim.fn.feedkeys(t("<C-n>"), "n")
      elseif is_prior_char_whitespace() then
        vim.fn.feedkeys(t("<cr>"), "n")
      else
        fallback()
      end
    end, {
        "i",
        "s",
      }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if vim.fn.complete_info()["selected"] == -1 and vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
        vim.fn.feedkeys(t("<C-R>=UltiSnips#ExpandSnippet()<CR>"))
      -- elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
      --   vim.fn.feedkeys(t("<ESC>:call UltiSnips#JumpForwards()<CR>"))
      -- place for emmet here
      elseif vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(t("<C-n>"), "n")
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
      elseif vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(t("<C-p>"), "n")
      else
        fallback()
      end
    end, {
        "i",
        "s",
      }),
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = (symbol_map[vim_item.kind] or "") .. " " .. vim_item.kind
      vim_item.menu = ({
        buffer = "[Buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
      })[entry.source.name]
      return vim_item
    end,
  },
})

require("nvim-autopairs.completion.cmp").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
  auto_select = true -- automatically select the first item
})


-- require'compe'.setup {
--   enabled = true;
--   autocomplete = true;
--   debug = false;
--   min_length = 2;
--   preselect = 'disable';
--   throttle_time = 120;
--   source_timeout = 200;
--   incomplete_delay = 400;
--   max_abbr_width = 80;
--   max_kind_width = 80;
--   max_menu_width = 80;
--   documentation = true;

--   source = {
--     nvim_lsp = { priority = 100, sort = false };
--     omni = { filetypes = { "css", "scss", "sass" } },
--     spell = true;
--     treesitter = false;
--     path = { priority = 90 };
--     buffer = true;
--     tags = false;
--     calc = false;
--     nvim_lua = true;
--     vsnip = true;
--     ultisnips = true;
--     tabnine = { priority = 95, sort = false, show_prediction_strength = true };
--   };
-- }


-- _G.tab_complete = function()
--   if vim.fn.pumvisible() == 1 then
--     return t("<C-n>")

--   elseif vim.fn["UltiSnips#CanExpandSnippet"]() == 1 or vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
--     return t("<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>")

--   elseif is_prior_char_whitespace() then
--     return t("<Tab>")

--   else
--     return vim.fn['compe#complete']()
--   end
-- end

-- _G.s_tab_complete = function()
--   if vim.fn.pumvisible() == 1 then
--     return t("<C-p>")

--   elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
--     return t("<C-R>=UltiSnips#JumpBackwards()<CR>")

--   else
--     return t("<S-Tab>")
--   end
-- end

-- imap("<Tab>", "v:lua.tab_complete()", {expr = true})
-- smap("<Tab>", "v:lua.tab_complete()", {expr = true})
-- imap("<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- smap("<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
