return {
  {
    'Saghen/blink.cmp',
    version = '1.*',
    dependencies = {
      'echasnovski/mini.icons',
      'fang2hou/blink-copilot',
    },
    opts = {
      enabled = function()
        local disabled_filetypes = { 'NvimTree', 'neo-tree' }
        return not vim.tbl_contains(disabled_filetypes, vim.bo.filetype)
      end,
      snippets = { preset = 'luasnip' },
      fuzzy = {
        implementation = 'prefer_rust_with_warning',
        sorts = { 'exact', 'score', 'sort_text' },
      },
      keymap = {
        preset = 'default',
        ['<C-j>']   = { 'show', 'fallback' },
        ['<Tab>']   = { 'snippet_forward', 'accept', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'accept', 'fallback' },
        ['<CR>']    = { 'accept', 'fallback' },
        ['<Up>']    = { 'select_prev', 'fallback' },
        ['<Down>']  = { 'select_next', 'fallback' },
      },
      signature = {
        enabled = true,
        window = {
          direction_priority = { 'n', 's' },
          border = 'single',
        },
      },
      completion = {
        list = { selection = { preselect = true, auto_insert = false } },
        trigger = {
          show_on_insert = true,
          show_on_blocked_trigger_characters = {},
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 100,
          treesitter_highlighting = true,
          window = {
            winhighlight = 'Pmenu:NormalDarker,Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker',
            border = 'solid',
            min_width = 40,
            direction_priority = {
              menu_north = { 'e', 'w' },
              menu_south = { 'e', 'w' },
            },
          },
        },
        menu = {
          scrollbar = false,
          border = 'none',
          winhighlight = 'Pmenu:NormalDarker,Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker',
        },
        ghost_text = { enabled = true },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
        providers = {
          lsp = {
            override = {
              get_trigger_characters = function(self)
                local trigger_characters = self:get_trigger_characters()
                vim.list_extend(trigger_characters, { '\n', '\t', ' ' })
                return trigger_characters
              end,
            },
          },
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
          },
        },
      },
    },
    config = function(_, opts)
      require('blink.cmp').setup(opts)

      -- Blink has no native option to cap ghost-text width, so long Copilot
      -- suggestions push the buffer to scroll horizontally. Wrap the ghost-text
      -- renderer and truncate the inline (first-line) preview.
      local max_width = 80
      local gt = require('blink.cmp.completion.windows.ghost_text')
      local hl_ns = require('blink.cmp.config').appearance.highlight_ns
      local orig_draw = gt.draw_preview
      gt.draw_preview = function(...)
        orig_draw(...)
        local buf, id = gt.extmark_buf, gt.extmark_id
        if not buf or not id or not vim.api.nvim_buf_is_valid(buf) then return end
        local mark = vim.api.nvim_buf_get_extmark_by_id(buf, hl_ns, id, { details = true })
        local details = mark[3]
        if not (details and details.virt_text and details.virt_text[1]) then return end
        local text = details.virt_text[1][1]
        if vim.fn.strchars(text) <= max_width then return end
        vim.api.nvim_buf_set_extmark(buf, hl_ns, mark[1], mark[2], {
          id = id,
          virt_text_pos = 'inline',
          virt_text = { { vim.fn.strcharpart(text, 0, max_width) .. '…', 'BlinkCmpGhostText' } },
          virt_lines = details.virt_lines,
          hl_mode = 'replace',
        })
      end
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
      require('luasnip.loaders.from_vscode').lazy_load({
        paths = { vim.fn.stdpath('config') .. '/snippets' },
      })
      require('luasnip.loaders.from_lua').lazy_load({
        paths = { vim.fn.stdpath('config') .. '/lua/snippets' },
      })
      local ls = require('luasnip')
      ls.filetype_extend('javascript', { 'jsdoc' })
      ls.filetype_extend('javascriptreact', { 'javascript', 'next', 'react-es7', 'react-native' })
      ls.filetype_extend('typescript', { 'tsdoc' })
      ls.filetype_extend('typescriptreact', { 'typescript', 'next-ts', 'react-ts', 'react-native-ts' })
    end,
  },
}
