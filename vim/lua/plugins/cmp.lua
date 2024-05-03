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
    'codota/tabnine-nvim',
    build = "./dl_binaries.sh",
    config = function()
      require('tabnine').setup({
        disable_auto_comment = true,
        accept_keymap = "<M-o>",
        dismiss_keymap = "<C-]>",
        debounce_ms = 800,
        suggestion_color = { gui = "#808080", cterm = 244 },
        exclude_filetypes = { "TelescopePrompt", "NvimTree" },
        log_file_path = nil, -- absolute path to Tabnine log file
      })

      local nnoremap = require("helper").nnoremap
      nnoremap("<C-k><C-a>", require("tabnine.chat").open)
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
            winhighlight = 'Normal:NormalDarker,FloatBorder:NormalDarker,CursorLine:Visual,Search:None',
            -- winhighlight = 'Normal:NormalDarker,FloatBorder:NormalDarker,CursorLine:CursorColumn,Search:None',
            col_offset = -3,
            side_padding = 0,
            -- border = 'rounded',
          },
          documentation = {
            winhighlight = 'Normal:NormalDarker,FloatBorder:NormalDarker,Search:None',
            -- border = 'rounded',
          },
        },
        sources = cmp.config.sources({
          -- { name = 'copilot',    priority = 150, group_index = 2 },
          -- { name = 'cmp_tabnine', priority = 145, group_index = 2 },
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
          -- ghost_text = {
          --   hl_group = "LspCodeLens",
          -- },
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            -- require("copilot_cmp.comparators").prioritize,
            -- require('cmp_tabnine.compare'),
            -- Below is the default comparitor list and order for nvim-cmp
            cmp.config.compare.offset,
            -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
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
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline([[/\V]], {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

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


-- require('copilot_cmp').setup()
-- cmp.event:on("menu_opened", function() vim.b.copilot_suggestion_hidden = true end)
-- cmp.event:on("menu_closed", function() vim.b.copilot_suggestion_hidden = false end)

-- cmp.setup({
-- mapping = cmp_mapping_config,
-- sorting = {
--   priority_weight = 2,
--   comparators = {
--     require('copilot_cmp.comparators').prioritize,
--     compare.offset,
--     compare.exact,
--     compare.score,
--     function(...) return cmp_helper.compare.prioritize_argument(...) end,
--     function(...) return cmp_helper.compare.deprioritize_underscore(...) end,
--     compare.recently_used,
--     compare.locality,
--     compare.kind,
--     compare.sort_text,
--     compare.length,
--     compare.order,
--   }
-- },
-- formatters = {
--   insert_text = require('copilot_cmp.format').remove_existing,
--   label = require("copilot_cmp.format").format_label_text,
--   -- insert_text = require("copilot_cmp.format").format_insert_text,
--   preview = require("copilot_cmp.format").deindent,
-- },
-- })
  -- {
  --   "github/copilot.vim",
  --   config = function()
  --     vim.keymap.set('i', '<C-h>', '<Plug>(copilot-accept-word)')
  --     vim.keymap.set('i', '<C-l>', '<Plug>(copilot-suggest)')

  --     vim.g.copilot_no_tab_map = true
  --   end
  -- },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   build = ":Copilot auth",
  --   opts = {
  --     suggestion = { enabled = true },
  --     panel = {
  --       enabled = true,
  --       layout = {
  --         position = "right",
  --         ratio = 0.3
  --       },
  --     },
  --     filetypes = {
  --       yaml = false,
  --       markdown = true,
  --       help = false,
  --       gitcommit = false,
  --       gitrebase = false,
  --       hgcommit = false,
  --       svn = false,
  --       cvs = false,
  --       sh = function()
  --         if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
  --           return false
  --         end
  --         return true
  --       end,
  --       ["."] = false,
  --     },
  --   },
  --   config = function(_, opts)
  --     local nnoremap = require("helper").nnoremap
  --     local inoremap = require("helper").inoremap

  --     require("copilot").setup(opts)

  --     inoremap("<M-l>", "<cmd>Copilot panel open<CR>")
  --     nnoremap("<M-l>", "<cmd>Copilot panel open<CR>")
  --     inoremap("<M-[>", "<cmd>Copilot panel jump_prev<CR>")
  --     inoremap("<M-]>", "<cmd>Copilot panel jump_next<CR>")
  --     nnoremap("<M-[>", "<cmd>Copilot panel jump_prev<CR>")
  --     nnoremap("<M-]>", "<cmd>Copilot panel jump_next<CR>")
  --     inoremap("<M-o>", "<cmd>Copilot panel accept<CR>")
  --     nnoremap("<M-o>", "<cmd>Copilot panel accept<CR>")
  --   end
  -- },
  -- {
  --   'tzachar/cmp-tabnine',
  --   build = './install.sh',
  --   dependencies = 'hrsh7th/nvim-cmp',
  --   config = function()
  --     local tabnine = require('cmp_tabnine.config')
  --     tabnine:setup({
  --       max_lines = 1000,
  --       max_num_results = 20,
  --       sort = true,
  --       run_on_every_keystroke = true,
  --       snippet_placeholder = '..',
  --       ignored_file_types = {},
  --       show_prediction_strength = false
  --     })
  --     local prefetch = vim.api.nvim_create_augroup("prefetch", { clear = true })

  --     vim.api.nvim_create_autocmd('BufRead', {
  --       group = prefetch,
  --       pattern = '*.py',
  --       callback = function()
  --         require('cmp_tabnine'):prefetch(vim.fn.expand('%:p'))
  --       end
  --     })
  --   end
  -- },
      -- {
      --   "zbirenbaum/copilot-cmp",
      --   dependencies = "copilot.lua",
      --   opts = {
      --     fix_pairs = true,
      --   },
      --   config = function(_, opts)
      --     local copilot_cmp = require("copilot_cmp")
      --     copilot_cmp.setup(opts)
      --     require("helper").on_attach(function(client)
      --       if client.name == "copilot" then
      --         copilot_cmp._on_insert_enter({})
      --       end
      --     end)
      --   end,
      -- },
