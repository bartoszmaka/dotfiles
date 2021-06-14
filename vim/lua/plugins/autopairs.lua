local config_helper = require('config_helper')
local inoremap = config_helper.inoremap
local npairs = require('nvim-autopairs')
local endwise = require('nvim-autopairs.ts-rule').endwise
local Rule   = require'nvim-autopairs.rule'

npairs.setup({
    check_ts = true,
    ts_config = {
        lua = {'string'},-- it will not add pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
    }
})

-- add space after
npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col, opts.col + 1)
      return vim.tbl_contains({ '()', '[]', '{}' }, pair)
    end),
  Rule('( ',' )')
    :with_pair(function() return false end)
    :with_move(function() return true end)
    :use_key(")")
}

-- endwise
npairs.add_rules({
  endwise('then$', 'end', 'ruby', 'if_statement'),
  endwise('$', 'end', 'lua', 'nil'),
})

vim.g.completion_confirm_key = ""
_G.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"](npairs.esc("<cr>"))
    else
      return npairs.esc("<cr>")
    end
  else
    return npairs.autopairs_cr()
  end
end

inoremap('<CR>','v:lua.completion_confirm()', {expr = true})
