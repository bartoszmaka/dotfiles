return {
  'hrsh7th/nvim-cmp',
  lazy = false,
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
    'f3fora/cmp-spell',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-omni',
    'hrsh7th/cmp-cmdline',
    {
      'zbirenbaum/copilot.lua',
      lazy = false
    },
    'zbirenbaum/copilot-cmp',
    {
      'tzachar/cmp-tabnine',
      build = './install.sh',
    }
  },
  config = function()
    local cmp = require('cmp')
    local compare = require('cmp.config.compare')
    local lspkind = require('lspkind')
    local cmp_buffer = require('cmp_buffer')
    local symbols = require('config_helper.symbols')
    local cmp_ultisnips_mappings = require('cmp_nvim_ultisnips.mappings')
    local inoremap = require('config_helper').inoremap
    local copilot_suggestion = require("copilot.suggestion")

    vim.cmd [[ set pumheight=10 ]]

    local t = function(str)
      return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    local cmp_helper = {
      compare = {
        deprioritize_underscore = function(lhs, rhs)
          local l = (lhs.completion_item.label:find '^_+') and 1 or 0
          local r = (rhs.completion_item.label:find '^_+') and 1 or 0
          if l ~= r then return l < r end
        end,
        prioritize_argument = function(lhs, rhs)
          local l = (lhs.completion_item.label:find '=$') and 1 or 0
          local r = (rhs.completion_item.label:find '=$') and 1 or 0
          if l ~= r then return l > r end
        end,
      },
    }

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
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        elseif vim.fn['UltiSnips#CanExpandSnippet']() == 1 then
          vim.api.nvim_feedkeys(t('<Plug>(ultisnips_expand)'), 'm', true)
        elseif vim.fn['UltiSnips#CanJumpForwards']() == 1 then
          return vim.api.nvim_feedkeys(t('<Plug>(ultisnips_jump_forward)'), 'm', true)
        elseif copilot_suggestion.is_visible() then
          copilot_suggestion.accept()
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

    local cmp_ultisnips_config = {
      expand = function(args)
        vim.fn['UltiSnips#Anon'](args.body)
      end,
    }

    local cmp_mapping_config = {
      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-l>'] = cmp.mapping.complete({ config = { sources = { name = 'copilot' } } }),
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
    }
    require('copilot_cmp').setup()
    cmp.event:on("menu_opened", function() vim.b.copilot_suggestion_hidden = true end)
    cmp.event:on("menu_closed", function() vim.b.copilot_suggestion_hidden = false end)

    require('cmp_tabnine.config').setup(
      {
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = '..',
        ignored_file_types = {
          -- default is not to ignore
          -- uncomment to ignore in lua:
          -- lua = true
        },
        show_prediction_strength = true
      }
    )
    local prefetch = vim.api.nvim_create_augroup("prefetch", { clear = true })
    vim.api.nvim_create_autocmd('BufRead', {
      group = prefetch,
      pattern = '*.rb',
      callback = function()
        require('cmp_tabnine'):prefetch(vim.fn.expand('%:p'))
      end
    })

    cmp.setup({
      snippet = cmp_ultisnips_config,
      window = {
        completion = {
          winhighlight = 'Normal:NormalDarker,FloatBorder:NormalDarker,CursorLine:Visual,Search:None',
          col_offset = -4,
          side_padding = 0,
          border = 'rounded',
        },
        documentation = {
          winhighlight = 'Normal:NormalDarker,FloatBorder:NormalDarker,Search:None',
          border = 'rounded',
        },
      },
      mapping = cmp_mapping_config,
      -- preselect = cmp.PreselectMode.None,
      -- completion = {},
      sources = {
        { name = 'copilot',     priority = 150 },
        { name = 'cmp_tabnine', priority = 145 },
        { name = 'ultisnips',   priority = 120 },
        { name = 'nvim_lsp',    priority = 110 },
        { name = 'path',        priority = 100 },
        {
          name = 'buffer',
          priority = 96,
          option = {
            keyword_pattern = [[\k\+]],
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
          }
        },
        { name = 'spell' },
      },
      sorting = {
        priority_weight = 2,
        comparators = {
          require('copilot_cmp.comparators').prioritize,
          compare.offset,
          compare.exact,
          compare.score,
          function(...) return cmp_helper.compare.prioritize_argument(...) end,
          function(...) return cmp_helper.compare.deprioritize_underscore(...) end,
          compare.recently_used,
          compare.locality,
          compare.kind,
          compare.sort_text,
          compare.length,
          compare.order,
        }
      },
      experimental = {
        ghost_text = false,
      },
      formatters = {
        insert_text = require('copilot_cmp.format').remove_existing,
        label = require("copilot_cmp.format").format_label_text,
        -- insert_text = require("copilot_cmp.format").format_insert_text,
        preview = require("copilot_cmp.format").deindent,
      },
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
          local menu = ({
                buffer = '[Buf]',
                omni = '[Omni]',
                ultisnips = '[Snip]',
                spell = '[Spell]',
                cmp_tabnine = '[TN]',
                copilot = '[AI]',
                cmdline = '[CMD]',
                nvim_lsp_signature_help = '~ [Sign]',
              })[entry.source.name] or entry.source.name

          if entry.source.name == 'nvim_lsp_signature_help' then
            vim_item.kind = string.format('%s %s', symbols.Function, 'Args')
          elseif entry.source.name == 'cmp_tabnine' then
            vim_item.kind = 'T TabNine'
          else
            vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = 'symbol_text' })
          end

          local strings = vim.split(vim_item.kind, '%s', { trimempty = true })
          vim_item.kind = ' ' .. strings[1] .. ' '
          if entry.source.name ~= "nvim_lsp" and strings[2] == "Text" then
            vim_item.menu = ' ' .. entry.source.name
          else
            vim_item.menu = ' ' .. strings[2]
          end

          return vim_item
        end
      },
    })

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

    cmp.setup.filetype({ 'css', 'scss', 'sass' }, {
      sources = {
        { name = 'ultisnips' },
        { name = 'copilot' },
        { name = 'nvim_lsp' },
        { name = 'omni' },
        { name = 'path' },
        { name = 'buffer',   get_bufnrs = function() return vim.api.nvim_list_bufs() end },
        { name = 'spell' },
      },
    })
    vim.cmd [[
      augroup cmp_overrides
        autocmd!
        highlight! CmpItemAbbr guifg=#6c7d9c
        highlight! CmpItemAbbrMatch guifg=#f2cc81
        highlight! CmpItemAbbrMatchFuzzy guifg=#f2cc81 gui=NONE
        highlight! CmpItemKindDefault guifg=#dd9046
        highlight! CmpItemKindSnippet guifg=#f65866
        highlight! CmpItemKindKeyword guifg=#bfbd5d
        highlight! CmpItemAbbrDeprecated guifg=#455574
        highlight! CmpItemKindText guifg=#93a4c3
        highlight! CmpItemKindCopilot guifg=#6CC644
      augroup END
    ]]
  end
}

-- is_prior_char_whitespace = function()
--   local col = vim.fn.col('.') - 1
--   return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
-- end,
-- has_words_before = function()
--   if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then return false end
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match('^%s*$') == nil
-- end
