local config_helper = require('config_helper')
local imap = config_helper.imap
local smap = config_helper.smap

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

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'disable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 80;
  max_kind_width = 80;
  max_menu_width = 80;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    tags = false;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    tabnine = false;
  };
}


local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local is_prior_char_whitespace = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t("<C-n>")

  elseif vim.fn["UltiSnips#CanExpandSnippet"]() == 1 or vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
    return t("<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>")

  elseif is_prior_char_whitespace() then
    return t("<Tab>")

  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t("<C-p>")

  elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
    return t("<C-R>=UltiSnips#JumpBackwards()<CR>")

  else
    return t("<S-Tab>")
  end
end

imap("<Tab>", "v:lua.tab_complete()", {expr = true})
smap("<Tab>", "v:lua.tab_complete()", {expr = true})
imap("<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
smap("<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
