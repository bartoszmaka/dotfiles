return {
  'nvim-treesitter/nvim-treesitter', -- syntax highlighting
  dependencies = {
    { 'nvim-treesitter/playground' },
    { 'p00f/nvim-ts-rainbow' },
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    { 'JoosepAlviste/nvim-ts-context-commentstring' },
    { 'nvim-treesitter/nvim-treesitter-context' },
    { 'm-demare/hlargs.nvim' }
  },
  build = ':TSUpdate',
  config = function()
    local nnoremap = require('helper').nnoremap

    require 'nvim-treesitter.configs'.setup {
      ensure_installed = "all",
      highlight = {
        enable = true,
        -- disable = function(lang, buf)
        --   local max_filesize = 100 * 1024 -- 100 KB
        --   local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        --   if ok and stats and stats.size > max_filesize then
        --     print('Disabling treesitter for buffer due to size ' .. stats.size .. ' bytes')
        --     return true
        --   end
        -- end,
        additional_vim_regex_highlighting = false
      },
      indent = {
        enable = true,
      },
      rainbow = {
        enable = true,
        extended_mode = false,
      },
      autopairs = {
        enable = true,
      },
      autotag = {
        enable = true,
        filetypes = {
          'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx',
          'rescript', 'xml', 'php', 'markdown', 'glimmer', 'handlebars', 'hbs', 'eruby'
        }
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
        enable = false,
        -- keymaps = {
        --   -- init_selection = '<CR>',
        --   -- scope_incremental = '<CR>',
        --   node_incremental = 'v',
        --   node_decremental = 'V',
        -- },
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

    vim.treesitter.language.register("bash", "env.local")
    vim.treesitter.language.register("yaml", "eruby.yaml")

    require 'treesitter-context'.setup {
      enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
      throttle = true,
    }

    -- nnoremap([[<leader>uH]], [[:TSHighlightCapturesUnderCursor<CR>]])

    require('hlargs').setup()

    vim.cmd [[
      augroup hlargs_overrides
      autocmd!
      highlight! Hlargs gui=italic
      augroup END
    ]]
  end
}
