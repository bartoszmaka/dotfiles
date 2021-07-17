local npairs = require('nvim-autopairs')
local Rule   = require'nvim-autopairs.rule'
local endwise = require('nvim-autopairs.ts-rule').endwise
local ts_conds = require('nvim-autopairs.ts-conds')

npairs.setup({
  check_ts = true,
  ts_config = {
    lua = {'string'},-- it will not add pair on that treesitter node
  }
})

require("nvim-autopairs.completion.compe").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = false -- it will auto insert `(` after select function or method item
})

-- add space after
npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col, opts.col + 1)
      return vim.tbl_contains({ '()', '[]', '{}' ,'=%'}, pair)
    end),
}

npairs.add_rules {
  Rule('<%=', '%>', 'eruby')
}

npairs.add_rules({
  Rule("%", "%", "lua")
    :with_pair(ts_conds.is_ts_node({'string','comment'})),
  Rule("$", "$", "lua")
    :with_pair(ts_conds.is_not_ts_node({'function'}))
})

npairs.add_rules({
  endwise('def', 'end', 'ruby'),
  endwise('if', 'end', 'ruby'),
  endwise('do', 'end', 'ruby'),
  endwise('class', 'end', 'ruby'),
  endwise('module', 'end', 'ruby'),
  endwise('$', 'end', 'lua', 'nil'),
})


