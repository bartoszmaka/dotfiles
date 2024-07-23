return {
  {
    'SirVer/ultisnips',
    config = function()
      -- vim.g.UltiSnipsRemoveSelectModeMappings = 0
      -- vim.g.UltiSnipsExpandTrigger = "<C-e>"
      -- vim.g.UltiSnipsJumpForwardTrigger = "<C-e>"
      -- vim.g.UltiSnipsJumpBackwardTrigger = "<C-b>"
      vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
      vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
      vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
      vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
      vim.g.UltiSnipsRemoveSelectModeMappings = 0

      vim.cmd [[
      augroup setup_snippet_aliases
        autocmd!

        autocmd FileType eruby UltiSnipsAddFiletypes eruby
        autocmd FileType javascript UltiSnipsAddFiletypes javascriptreact
        autocmd FileType typescript UltiSnipsAddFiletypes javascript.javascriptreact
        autocmd FileType javascriptreact UltiSnipsAddFiletypes javascript
        autocmd FileType typescriptreact UltiSnipsAddFiletypes javascript.typescript.javascriptreact
        autocmd FileType javascript.jsx UltiSnipsAddFiletypes javascript.javascriptreact.javascript.jsx
        autocmd FileType typescript.tsx UltiSnipsAddFiletypes javascript.typescript.javascriptreact.javascript.jsx
        autocmd FileType vue UltiSnipsAddFiletypes javascript.typescript.javascriptreact.javascript.jsx
      augroup END
    ]]
    end
  },
  {
    'hrsh7th/nvim-cmp',
    version = false,
    event = "InsertEnter",
    dependencies = {
      {
        'quangnguyen30192/cmp-nvim-ultisnips',
        config = function()
          require('cmp_nvim_ultisnips').setup {
            filetype_source = 'treesitter',
            show_snippets = 'expandable',
            documentation = function(snippet)
              return snippet.description
            end
          }
        end
      },
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'f3fora/cmp-spell',
      'hrsh7th/cmp-omni',
      'hrsh7th/cmp-cmdline',
      {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        config = function()
          require("tailwindcss-colorizer-cmp").setup({
            color_square_width = 1,
          })
        end
      }
    },
    opts = function()
      local cmp = require('cmp')
      local helper = require('helper')
      local cmp_helper = require('helper.cmp')
      local tabnine_loaded, tabnine_keymaps = pcall(require,'tabnine.keymaps')
      local get = helper.get
      local t = cmp_helper.t
      local mappings = {
        next_or_open_popup = function()
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          else
            cmp.complete()
          end
        end,
        prev_or_open_popup = function()
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
          else
            cmp.complete()
          end
        end,
        insert_tab_mapping = function(fallback)
          print(vim.inspect({tabnine_loaded, tabnine_keymaps.has_suggestion()}))
          if vim.fn['UltiSnips#CanExpandSnippet']() == 1 then
            vim.api.nvim_feedkeys(t('<Plug>(ultisnips_expand)'), 'm', true)
          elseif vim.fn['UltiSnips#CanJumpForwards']() == 1 then
            return vim.api.nvim_feedkeys(t('<Plug>(ultisnips_jump_forward)'), 'm', true)
          elseif cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          elseif tabnine_loaded and tabnine_keymaps.has_suggestion() then
            tabnine_keymaps.accept_suggestion()
          else
            vim.fn.feedkeys(t('<tab>'), 'n')
          end
        end,
        snippet_tab_mapping = function(fallback)
          if vim.fn['UltiSnips#CanJumpForwards']() == 1 then
            return vim.api.nvim_feedkeys(t('<Plug>(ultisnips_jump_forward)'), 'm', true)
          else
            fallback()
          end
        end,
        insert_shift_tab_mapping = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
          elseif vim.fn['UltiSnips#CanJumpBackwards']() == 1 then
            return vim.api.nvim_feedkeys(t('<Plug>(ultisnips_jump_backward)'), 'm', true)
          else
            vim.fn.feedkeys(t('<esc><<<left><left>a'), 'n')
          end
        end,
        snippet_shift_tab_mapping = function(fallback)
          if vim.fn['UltiSnips#CanJumpBackwards']() == 1 then
            return vim.api.nvim_feedkeys(t('<Plug>(ultisnips_jump_backward)'), 'm', true)
          else
            fallback()
          end
        end,
      }

      local options = {
        completion = {},
        mapping = {
          ['<C-e>'] = cmp.mapping.abort(),
          ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
          ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-j>'] = cmp.mapping(mappings.next_or_open_popup),
          ['<C-k>'] = cmp.mapping(mappings.prev_or_open_popup),
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = false,
          }),
          ['<Tab>'] = cmp.mapping({
            c = mappings.next_or_open_popup,
            i = function(fallback) mappings.insert_tab_mapping(fallback) end,
            s = function(fallback) mappings.snippet_tab_mapping(fallback) end
          }),
          ['<S-Tab>'] = cmp.mapping({
            c = mappings.prev_or_open_popup,
            i = function(fallback) mappings.insert_shift_tab_mapping(fallback) end,
            s = function(fallback) mappings.snippet_shift_tab_mapping(fallback) end
          }),
        },
        snippet = {
          expand = function(args)
            vim.fn['UltiSnips#Anon'](args.body)
          end,
        },
        window = {
          completion = {
            winhighlight = 'Normal:NormalDarker,FloatBorder:NormalDarker,Search:None',
            col_offset = -3,
            side_padding = 0,
          },
          documentation = {
            winhighlight = 'Normal:NormalDarker,FloatBorder:NormalDarker,Search:None',
          },
        },
        sources = cmp.config.sources({
          { name = 'ultisnips', priority = 120, group_index = 2 },
          { name = "nvim_lsp",  priority = 100, group_index = 2 },
          { name = "buffer",    priority = 55,  group_index = 2 },
          { name = "path",      priority = 50,  group_index = 2 },
          { name = 'spell',     priority = 45,  group_index = 2 },
        }),

        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = cmp_helper.format_entry
        },
        experimental = {
          ghost_text = false
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        }
      }

      return options
    end,
    config = function(_, opts)
      require('cmp').setup(opts)
    end,
    init = function()
      local cmp = require('cmp')
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end
  }
}
