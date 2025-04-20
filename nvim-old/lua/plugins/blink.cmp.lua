return {
  "saghen/blink.cmp",
  opts = {
    fuzzy = { implementation = "lua" },
    completion = {
      list = { selection = { preselect = false, auto_insert = false } },
      menu = {
        auto_show = true,
        draw = {
          columns = {
            { "kind_icon", "label", "label_description", gap = 1 },
            { "kind",      gap = 1 }
          },
          components = {
            kind_icon = {
              highlight = function(ctx)
                return { { group = ctx.kind_hl, priority = 20000 } }
              end
            }
          }
        },
      },

      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      ghost_text = {
        enabled = true,
        show_with_selection = true,
        show_without_selection = true,
        show_with_menu = true,
        show_without_menu = true,
      },
    },
    keymap = {
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide' },
      ['<C-y>'] = { 'select_and_accept' },

      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
      ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

      ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },

      ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
    },
  },
}
