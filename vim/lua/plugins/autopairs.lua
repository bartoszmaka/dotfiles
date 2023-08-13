return {
  'windwp/nvim-autopairs',
  config = function()
    local npairs   = require('nvim-autopairs')
    local Rule     = require 'nvim-autopairs.rule'
    local endwise  = require('nvim-autopairs.ts-rule').endwise
    local ts_conds = require('nvim-autopairs.ts-conds')

    npairs.setup({
      check_ts = true,
      ts_config = {
        lua = { 'string' }, -- it will not add pair on that treesitter node
      }
    })

    -- add space after
    npairs.add_rules {
      Rule(' ', ' ')
        :with_pair(function(opts)
          local pair = opts.line:sub(opts.col - 1, opts.col)
          return vim.tbl_contains({ '()', '[]', '{}' }, pair)
        end),
    }

    npairs.add_rules {
      Rule('( ', ' )')
        :with_pair(function() return false end)
        :with_move(function() return true end)
        :use_key(")")
    }

    npairs.add_rules {
      Rule('<%', ' %>', 'eruby'),
    }

    npairs.add_rules({
      Rule("%", "%", "lua")
        :with_pair(ts_conds.is_ts_node({ 'string', 'comment' })),
      Rule("$", "$", "lua")
        :with_pair(ts_conds.is_not_ts_node({ 'function' }))
    })

    npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
    npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))
  end
}
