local nnoremap = require('config_helper').nnoremap

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  ignore_install = { "phpdoc" },
  highlight = {
    enable = true,
    disable = { "fzf", "fugitive", "NvimTree" },
    additional_vim_regex_highlighting = false
  },
  indent = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = false,
  },
  autopairs = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  -- matchup = { enable = true },
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
      -- init_selection = '<CR>',
      -- scope_incremental = '<CR>',
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
        ["]w"] = "@parameter.inner",
      },
      swap_previous = {
        ["[w"] = "@parameter.inner",
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
    -- lsp_interop = {
    --   enable = true,
    --   border = 'none',
    --   peek_definition_code = {
    --     ["<leader>df"] = "@function.outer",
    --     ["<leader>dF"] = "@class.outer",
    --   },
    -- },
  },
}

local ft_to_parser = require"nvim-treesitter.parsers".filetype_to_parsername
ft_to_parser["env.local"] = "bash" -- the someft filetype will use the python parser and queries.

require'treesitter-context'.setup {
  enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
  throttle = true,
}

nnoremap([[<leader>dh]], [[:TSHighlightCapturesUnderCursor<CR>]])
