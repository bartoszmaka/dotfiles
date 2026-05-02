return {
  {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      local colors = require('helper.colors').onedark

      vim.o.termguicolors = true
      vim.o.background = 'dark'

      require('onedark').setup({
        style = 'deep',
        term_colors = false,
        colors = colors,
        code_style = {
          comments  = 'italic',
          keywords  = 'italic',
          functions = 'none',
          strings   = 'none',
          variables = 'none',
        },
        highlights = {
          DiffChange = { bg = colors.diff_change, fg = 'none' },
          DiffText   = { bg = colors.diff_text,   fg = 'none' },
          DiffAdd    = { bg = colors.diff_add,    fg = 'none' },
          DiffDelete = { bg = colors.diff_delete, fg = 'none' },
          MsgArea    = { bg = colors.bg_d },
          ['@boolean']                = { fmt = 'italic' },
          ['@constant.builtin']       = { fmt = 'italic', fg = colors.red },
          ['@include']                = { fmt = 'italic' },
          ['@keyword']                = { fmt = 'italic' },
          ['@keyword.function']       = { fmt = 'italic' },
          ['@variable.builtin']       = { fmt = 'italic' },
          ['@conditional']            = { fmt = 'none' },
          ['@constructor']            = { fmt = 'none' },
          ['@lsp.type.variable']      = { fmt = 'none' },
          ['BlinkCmpLabelMatch']      = { fg = colors.bg_yellow },
          ['CmpItemAbbr']             = { fg = '#6c7d9c' },
          ['CmpItemAbbrMatch']        = { fg = colors.bg_yellow },
          ['CmpItemAbbrMatchFuzzy']   = { fg = colors.bg_yellow, fmt = 'none' },
          ['CmpItemAbbrDeprecated']   = { fg = colors.grey },
          ['CmpItemKindDefault']      = { fg = colors.orange },
          ['CmpItemKindSnippet']      = { fg = colors.red },
          ['CmpItemKindKeyword']      = { fg = '#bfbd5d' },
          ['CmpItemKindText']         = { fg = colors.fg },
          ['CmpItemKindCopilot']      = { fg = '#6CC644' },
          ['RainbowParenBlue']        = { fg = colors.blue },
          ['RainbowParenCyan']        = { fg = colors.cyan },
          ['RainbowParenGreen']       = { fg = colors.green },
          ['RainbowParenOrange']      = { fg = colors.orange },
          ['RainbowParenRed']         = { fg = colors.red },
          ['RainbowParenPurple']      = { fg = colors.purple },
          ['RainbowParenYellow']      = { fg = colors.yellow },
          ['RainbowIndentBlue']       = { fg = colors.dimmed_blue },
          ['RainbowIndentCyan']       = { fg = colors.dimmed_cyan },
          ['RainbowIndentGreen']      = { fg = colors.dimmed_green },
          ['RainbowIndentOrange']     = { fg = colors.dimmed_orange },
          ['RainbowIndentRed']        = { fg = colors.dimmed_red },
          ['RainbowIndentPurple']     = { fg = colors.dimmed_purple },
          ['RainbowIndentYellow']     = { fg = colors.dimmed_yellow },
          ['Winbar']                  = { fmt = 'none' },
          ['NormalDarker']            = { bg = colors.bg_d, fg = colors.fg },
          ['SignColumnDarker']        = { bg = colors.bg_d, fg = colors.fg },
          ['EndOfBufferDarker']       = { bg = colors.bg_d, fg = colors.bg_d },
          ['WinSeparatorDarker']      = { bg = colors.bg_d, fg = colors.bg3 },
          ['CursorLine']              = { bg = colors.bg1 },
          ['CursorLineNR']            = { bg = colors.bg1, fmt = 'bold' },
          ['CursorColumn']            = { bg = colors.bg1 },
          ['ColorColumn']             = { bg = colors.bg1 },
          ['Warning']                 = { bg = '#443333' },
          ['Error']                   = { bg = '#512121' },
          ['Visual']                  = { bg = '#401437' },
          ['DiagnosticVirtualTextHint'] = { fg = colors.dark_cyan, bg = 'NONE' },
          ['DiagnosticVirtualTextInfo'] = { fg = colors.dark_cyan, bg = 'NONE' },
          ['DiagnosticUnderlineError']  = { bg = '#512121', fmt = 'NONE' },
          ['DiagnosticUnderlineWarn']   = { bg = '#443333', fmt = 'NONE' },
          ['DiagnosticUnderlineInfo']   = { bg = 'NONE',    fmt = 'NONE' },
          ['DiagnosticUnderlineHint']   = { bg = 'NONE',    fmt = 'NONE' },
          ['FoldColumn']                = { bg = colors.bg0, fg = colors.grey },
          ['SignColumn']                = { fg = colors.bg1 },
          ['TreesitterContext']         = { bg = colors.bg_d },
          ['TreesitterContextLineNumber'] = { bg = colors.bg_d },
          ['CursorLineSign']            = { fg = colors.bg1 },
          ['IncSearch']                 = { fg = '#FF0000', bg = 'NONE', fmt = 'bold,nocombine' },
          ['CurSearch']                 = { fg = '#FF0000', bg = 'NONE', fmt = 'bold,nocombine' },
          ['Search']                    = { fg = colors.white, bg = 'NONE', fmt = 'bold,nocombine' },
        },
      })
      require('onedark').load()

      local hl = function(name, val) vim.api.nvim_set_hl(0, name, val) end
      hl('NormalFloat',         { link = 'Normal' })
      hl('FloatBorder',         { link = 'Normal' })
      hl('NormalDarker',        { bg = colors.bg_d, fg = colors.fg })
      hl('SignColumnDarker',    { bg = colors.bg_d, fg = colors.fg })
      hl('EndOfBufferDarker',   { bg = colors.bg_d, fg = colors.bg_d })
      hl('WinSeparatorDarker',  { bg = colors.bg_d, fg = colors.bg3 })
      hl('WhichKeyNormal',      { link = 'NormalDarker' })
      hl('WhichKeyBorder',      { link = 'NormalDarker' })
      hl('LazyNormal',          { link = 'NormalDarker' })

      local panel_filetypes = { 'Mundo', 'MundoDiff', 'floaterm', 'help', 'lspinfo', 'mason' }
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('make_panels_darker', { clear = true }),
        pattern = panel_filetypes,
        callback = function()
          vim.opt_local.winhighlight =
            'Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker'
        end,
      })

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('trouble_no_colorcolumn', { clear = true }),
        pattern = 'Trouble',
        callback = function() vim.opt_local.colorcolumn = '' end,
      })

      -- Treesitter / LSP highlight overrides
      local ts_links = {
        ['@function.builtin.ruby']                            = '@keyword',
        ['@keyword.function']                                 = '@keyword',
        ['@lsp.type.comment']                                 = '@comment',
        ['@lsp.type.function']                                = '@function',
        ['@lsp.type.macro']                                   = '@macro',
        ['@lsp.type.method']                                  = '@method',
        ['@lsp.type.namespace']                               = '@namespace',
        ['@lsp.type.parameter']                               = '@parameter',
        ['@lsp.type.property']                                = '@property',
        ['@lsp.type.type']                                    = '@type',
        ['@lsp.type.variable.javascript']                     = 'Special',
        ['@lsp.type.variable.typescriptreact']                = 'Special',
        ['@lsp.typemod.function.declaration.typescriptreact'] = '@type',
        ['@lsp.typemod.function.readonly.typescriptreact']    = '@type',
        ['@lsp.typemod.variable.readonly.javascript']         = '@type',
        ['@parameter']                                        = '@variable.builtin',
        ['@string.special.symbol.ruby']                       = 'Constant',
        ['@string.special.url.html']                          = 'Normal',
        ['@tag']                                              = 'Special',
        ['@tag.attribute']                                    = '@boolean',
        ['@tag.delimiter']                                    = 'Special',
        ['@tag.delimiter.javascript']                         = 'Normal',
        ['@tag.delimiter.tsx']                                = 'Normal',
        ['@tag.javascript']                                   = '@type',
        ['@tag.tsx']                                          = 'Type',
        ['@variable.member.ruby']                             = 'Special',
        ['@variable.parameter.ruby']                          = 'Special',
        ['TSTagAttribute']                                    = 'TSBoolean',
        ['htmlBold']                                          = 'Normal',
        ['htmlBoldItalic']                                    = 'Normal',
        ['htmlBoldItalicUnderline']                           = 'Normal',
        ['vueTSMethod']                                       = 'TSBoolean',
      }
      for name, target in pairs(ts_links) do
        hl(name, { link = target })
      end
      hl('@error.ruby', {})
    end,
  },
}
