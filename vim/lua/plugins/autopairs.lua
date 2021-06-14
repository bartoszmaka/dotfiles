local npairs = require('nvim-autopairs')
local endwise = require('nvim-autopairs.ts-rule').endwise

npairs.setup({
    check_ts = true,
    ts_config = {
        lua = {'string'},-- it will not add pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
    }
})

npairs.add_rules({
-- then$ is a lua regex
-- end is a match pair
-- lua is a filetype
-- if_statement is a treesitter name. set it = nil to skip check with treesitter
    endwise('then$', 'end', 'lua', 'if_statement')
})
