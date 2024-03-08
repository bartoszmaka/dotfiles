return {
  'nvim-treesitter/nvim-treesitter', -- syntax highlighting
  dependencies = {
    { 'nvim-treesitter/playground' },
    -- { 'p00f/nvim-ts-rainbow' },
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    { 'JoosepAlviste/nvim-ts-context-commentstring' },
    { 'nvim-treesitter/nvim-treesitter-context' },
    { 'm-demare/hlargs.nvim' }
  },
  build = ':TSUpdate',
  config = function()
    local nnoremap = require('helper').nnoremap
    vim.g.skip_ts_context_commentstring_module = true
    require('ts_context_commentstring').setup({
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
    })

    require 'nvim-treesitter.configs'.setup {
      -- rainbow = {
      --   enable = true,
      --   extended_mode = false,
      -- },
      ensure_installed = "all",
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
      },
      indent = { enable = true, },
      autopairs = { enable = true, },
      autotag = {
        enable = true,
      },
      -- matchup = { enable = true },
      incremental_selection = {
        enable = false,
        -- keymaps = {
        --   init_selection = '<CR>',
        --   scope_incremental = '<CR>',
        --   node_incremental = 'v',
        --   node_decremental = 'V',
        -- },
      },
      textobjects = {
        lookahead = true,
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["aC"] = "@class.outer",
            ["iC"] = "@class.inner",
            ["ac"] = "@conditional.outer",
            ["ic"] = "@conditional.inner",
          },
        },
        -- swap = {
        --   enable = true,
        --   swap_next = {
        --     ["]w"] = "@parameter.inner",
        --   },
        --   swap_previous = {
        --     ["[w"] = "@parameter.inner",
        --   },
        -- },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]C"] = "@class.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[C"] = "@class.outer",
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

    vim.treesitter.language.register("bash", "env.local")
    vim.treesitter.language.register("yaml", "eruby.yaml")

    require 'treesitter-context'.setup {
      enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
      throttle = true,
    }

    nnoremap([[<leader>uH]], [[:TSHighlightCapturesUnderCursor<CR>]])

    require('hlargs').setup()

    vim.cmd [[
      augroup fix_autotag_for_eruby_not_setting_up_for_some_reason
        autocmd!
        autocmd FileType eruby lua require('nvim-ts-autotag').setup()
        autocmd FileType * call v:lua.require('nvim-ts-autotag.internal').attach()
        autocmd BufDelete * lua require('nvim-ts-autotag.internal').detach(vim.fn.expand('<abuf>'))
      augroup END
    ]]
  end
}
