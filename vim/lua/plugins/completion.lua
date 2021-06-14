local npairs = require('nvim-autopairs')
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
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
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
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
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"](npairs.esc("<cr>"))
    else
      return npairs.esc("<cr>")
    end
    -- return t("<C-n>")

  elseif vim.fn["UltiSnips#CanExpandSnippet"]() == 1 or vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
    return t("<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>")

  elseif is_prior_char_whitespace() then
    return t("<Tab>")

  else
    return vim.fn['compe#complete']()
  end
end
  -- if vim.fn.pumvisible() == 1  then
  -- else
  --   return npairs.autopairs_cr()
  -- end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t("<C-p>")

  elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
    return t("<C-R>=UltiSnips#JumpBackwards()<CR>")

  else
    return t("<S-Tab>")
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
