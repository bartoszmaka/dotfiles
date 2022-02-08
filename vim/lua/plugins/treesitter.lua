require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = { enable = true },
  indent = { enable = true },
  rainbow = { enable = true },
  autopairs = {
    enable = true,
    filetypes = {'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'eruby', 'lua', 'ruby' }
  },
  autotag = {
    enable = true,
    filetypes = { 'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'eruby' }
  },
  matchup = { enable = true },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    config = {
      javascript = {
        __default = '// %s',
        jsx_element = '{/* %s */}',
        jsx_fragment = '{/* %s */}',
        jsx_attribute = '// %s',
        comment = '// %s'
      },
      typescriptreact = {
        __default = '// %s',
        jsx_element = '{/* %s */}',
        jsx_fragment = '{/* %s */}',
        jsx_attribute = '// %s',
        comment = '// %s'
      },
      toml = {
        __default = '# %s'
      },
    }
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = 'v',
      node_decremental = 'V',
    },
  },
  textobjects = {
    lookahead = true,
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["aC"] = "@class.outer",
        ["iC"] = "@class.inner",
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["[w"] = "@parameter.inner",
      },
      swap_previous = {
        ["]w"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
  },
}

local ft_to_parser = require"nvim-treesitter.parsers".filetype_to_parsername
ft_to_parser["env.local"] = "bash" -- the someft filetype will use the python parser and queries.

require'treesitter-context.config'.setup {
  enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
  throttle = true,
}

vim.g.matchup_matchparen_offscreen           = {method = 'popup'}
vim.g.matchup_matchparen_deferred            = 1
vim.g.matchup_matchparen_hi_surround_always  = 0
vim.g.matchup_matchparen_timeout             = 350
vim.g.matchup_matchparen_insert_timeout      = 150
vim.g.matchup_matchparen_deferred_show_delay = 120
vim.g.matchup_matchparen_deferred_hide_delay = 500
vim.g.matchup_matchparen_stopline            = 40
vim.g.matchup_motion_override_Npercent       = 0

-- vim.cmd [[
-- augroup reparse_treesitter
--   autocmd!
--   autocmd BufReadPost,FileReadPost *.lua echomsg('aaa')
-- augroup END
-- ]]

vim.cmd [[
augroup matchup_config
autocmd!
  highlight! MatchParen        guifg=NONE    guibg=NONE gui=bold,underline
  highlight! MatchParenCur     guifg=NONE    guibg=NONE gui=bold,underline
  highlight! TSConstructor     gui=none
  highlight! TSInclude         gui=italic
  highlight! TSKeyword         gui=italic
  highlight! TSKeywordFunction gui=italic
  highlight! TSVariableBuiltin gui=italic
  highlight! TSConditional     gui=italic

  highlight! link vueTSMethod TSBoolean
  highlight! link TSTagAttribute TSBoolean

augroup END

nnoremap <leader>dh :TSHighlightCapturesUnderCursor<CR>
nnoremap <C-k><C-k> :MatchupWhereAmI!!<CR>
]]
