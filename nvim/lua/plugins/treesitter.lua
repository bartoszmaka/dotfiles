return {
  'nvim-treesitter/nvim-treesitter', -- syntax highlighting
  dependencies = {
    { 'nvim-treesitter/playground' },
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    { 'JoosepAlviste/nvim-ts-context-commentstring' },
    { 'nvim-treesitter/nvim-treesitter-context' },
    { 'm-demare/hlargs.nvim' },
    { 'windwp/nvim-ts-autotag' }, -- automatically add matching tags
    { 'windwp/nvim-autopairs' }
  },
  build = ':TSUpdate',
  config = function()
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
      ensure_installed = "all",
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
      },
      indent = { enable = true, },
      autopairs = { enable = true, },
      -- autotag = {
      --   enable = true,
      -- },
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

    local npairs   = require('nvim-autopairs')
    local Rule     = require 'nvim-autopairs.rule'
    -- local endwise  = require('nvim-autopairs.ts-rule').endwise
    -- local ts_conds = require('nvim-autopairs.ts-conds')

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

    npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
    npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))

    -- nnoremap([[<leader>uH]], [[:TSHighlightCapturesUnderCursor<CR>]])

    require('hlargs').setup()

    require('nvim-ts-autotag').setup()

    vim.cmd [[
      augroup fix_autotag_for_eruby_not_setting_up_for_some_reason
        autocmd!
        autocmd FileType eruby lua require('nvim-ts-autotag').setup()
        autocmd FileType * call v:lua.require('nvim-ts-autotag.internal').attach()
        autocmd BufDelete * lua require('nvim-ts-autotag.internal').detach(vim.fn.expand('<abuf>'))
      augroup END

      augroup hlargs_overrides
        autocmd!
        highlight! Hlargs guibg=none guifg=none gui=italic
      augroup END

      augroup treesitter_overrides
        autocmd!
        autocmd FileType javascript highlight! link graphqlStructure Constant
        autocmd FileType javascript highlight! link graphqlVariable Type
        autocmd FileType javascript highlight! link graphqlName String
        autocmd FileType javascript highlight! link graphqlType Constant
        autocmd FileType javascript highlight! link graphqlStructure Label
        autocmd FileType javascript highlight! link TSTag TSConstructor

        highlight! @error.ruby guibg=NONE guifg=NONE gui=NONE

        highlight! link @parameter   @variable.builtin
        highlight! link vueTSMethod TSBoolean
        highlight! link TSTagAttribute TSBoolean
        highlight! link @tag.attribute @boolean
        highlight! link @tag Special
        highlight! link @tag.delimiter Special
        highlight! link @keyword.function @keyword
        highlight! link htmlBold Normal
        highlight! link htmlBoldItalic Normal
        highlight! link htmlBoldItalicUnderline Normal
        highlight! link @lsp.type.type @type
        highlight! link @lsp.type.macro @macro
        highlight! link @lsp.type.method @method
        highlight! link @lsp.type.comment @comment
        highlight! link @lsp.type.function @function
        highlight! link @lsp.type.property @property
        highlight! link @lsp.type.namespace @namespace
        highlight! link @lsp.type.parameter @parameter

        " html | eruby"
        highlight! link @string.special.url.html Normal

        " ruby
        highlight! link @variable.member.ruby Special
        highlight! link @variable.parameter.ruby Special
        highlight! link @string.special.symbol.ruby Constant
        highlight! link @function.builtin.ruby @keyword

        " typescript
        highlight! link @tag.delimiter.tsx Normal
        highlight! link @tag.tsx Type
        highlight! link @lsp.typemod.function.declaration.typescriptreact @type
        highlight! link @lsp.typemod.function.readonly.typescriptreact @type
        highlight! link @lsp.type.variable.typescriptreact Special

        " javascript
        highlight! link @lsp.typemod.variable.readonly.javascript @type
        highlight! link @lsp.typemod.variable.readonly.javascript @type
        highlight! link @tag.delimiter.javascript Normal
        highlight! link @lsp.type.variable.javascript Special
        highlight! link @tag.javascript @type
      augroup END
      ]]
  end
}
