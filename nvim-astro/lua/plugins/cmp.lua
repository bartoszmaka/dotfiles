return { -- override nvim-cmp plugin
  "hrsh7th/nvim-cmp",
  lazy = false,
  dependencies = {
    {
      "roobert/tailwindcss-colorizer-cmp.nvim",
      config = function()
        require("tailwindcss-colorizer-cmp").setup({
          color_square_width = 1,
        })
      end
    },
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
  },
  opts = function()
    local cmp = require('cmp')
    local cmp_helper = require('helper.cmp_helper')
    local tabnine_loaded, tabnine_keymaps = pcall(require,'tabnine.keymaps')
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
}
