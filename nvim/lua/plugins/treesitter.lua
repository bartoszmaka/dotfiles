return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install {
        "bash", "comment", "css", "scss", "diff", "dockerfile",
        "eruby", "git_config", "gitcommit", "gitignore",
        "graphql", "html", "javascript", "jsdoc", "json", "json5",
        "lua", "make", "markdown", "markdown_inline", "python",
        "regex", "ruby", "rust", "sql", "toml", "tsx", "typescript",
        "vim", "vimdoc", "yaml",
      }

      vim.treesitter.language.register("bash", "env.local")
      vim.treesitter.language.register("yaml", "eruby.yaml")
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = "main",
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require("nvim-treesitter-textobjects").setup {
        select = {
          lookahead = true,
          include_surrounding_whitespace = false,
        },
        move = { set_jumps = true },
      }

      local select = require("nvim-treesitter-textobjects.select")
      vim.keymap.set({ "x", "o" }, "af", function() select.select_textobject("@function.outer", "textobjects") end)
      vim.keymap.set({ "x", "o" }, "if", function() select.select_textobject("@function.inner", "textobjects") end)
      vim.keymap.set({ "x", "o" }, "aC", function() select.select_textobject("@class.outer", "textobjects") end)
      vim.keymap.set({ "x", "o" }, "iC", function() select.select_textobject("@class.inner", "textobjects") end)
      vim.keymap.set({ "x", "o" }, "ac", function() select.select_textobject("@conditional.outer", "textobjects") end)
      vim.keymap.set({ "x", "o" }, "ic", function() select.select_textobject("@conditional.inner", "textobjects") end)

      local move = require("nvim-treesitter-textobjects.move")
      vim.keymap.set({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "]C", function() move.goto_next_start("@class.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "[C", function() move.goto_previous_start("@class.outer", "textobjects") end)
    end,
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    lazy = true,
    init = function() vim.g.skip_ts_context_commentstring_module = true end,
    opts = {
      javascript = {
        __default = '// %s',
        jsx_element = '{/* %s */}',
        jsx_fragment = '{/* %s */}',
        jsx_attribute = '// %s',
        comment = '// %s',
      },
      typescriptreact = {
        __default = '// %s',
        jsx_element = '{/* %s */}',
        jsx_fragment = '{/* %s */}',
        jsx_attribute = '// %s',
        comment = '// %s',
      },
      toml = { __default = '# %s' },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      max_lines = 4,
      multiline_threshold = 2,
    },
  },
  { 'windwp/nvim-ts-autotag', event = "InsertEnter", opts = {} },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
      local npairs = require('nvim-autopairs')
      local Rule = require('nvim-autopairs.rule')

      npairs.setup({ check_ts = true, ts_config = { lua = { 'string' } } })

      npairs.add_rules {
        Rule(' ', ' '):with_pair(function(opts)
          return vim.tbl_contains({ '()', '[]', '{}' }, opts.line:sub(opts.col - 1, opts.col))
        end),
      }
      npairs.add_rules {
        Rule('( ', ' )'):with_pair(function() return false end):with_move(function() return true end):use_key(")"),
      }
      npairs.add_rules { Rule('<%', ' %>', 'eruby') }
      npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
      npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))
    end,
  },
  {
    'm-demare/hlargs.nvim',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require('hlargs').setup()
      vim.api.nvim_set_hl(0, "Hlargs", { italic = true })
    end,
  },
}
