return {
  {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      local colors = require('helper.colors').onedark

      vim.o.termguicolors = true
      vim.o.background = "dark"

      require('onedark').setup({
        style = 'deep',
        term_colors = 'false',
        colors = colors,
        code_style = {
          comments = 'italic',
          keywords = 'italic',
          functions = 'none',
          strings = 'none',
          variables = 'none'
        },
        highlights = {
          DiffChange                    = { bg = colors.diff_change, fg = "none" },
          DiffText                      = { bg = colors.diff_text, fg = "none" },
          DiffAdd                       = { bg = colors.diff_add, fg = "none" },
          DiffDelete                    = { bg = colors.diff_delete, fg = "none" },
          MsgArea                       = { bg = colors.bg_d },
          ['@boolean']                  = { fmt = 'italic' },
          ['@constant.builtin']         = { fmt = 'italic', fg = colors.red },
          ['@include']                  = { fmt = 'italic' },
          ['@keyword']                  = { fmt = 'italic' },
          ['@keyword.function']         = { fmt = 'italic' },
          ['@variable.builtin']         = { fmt = 'italic' },
          ['@conditional']              = { fmt = 'none' },
          ['@constructor']              = { fmt = 'none' },
          ['@lsp.type.variable']        = { fmt = 'none' },
          ['BlinkCmpLabelMatch']        = { fg = '#f2cc81' },
          ['CmpItemAbbr']               = { fg = '#6c7d9c' },
          ['CmpItemAbbrMatch']          = { fg = '#f2cc81' },
          ['CmpItemAbbrMatchFuzzy']     = { fg = '#f2cc81', fmt = 'none' },
          ['CmpItemAbbrDeprecated']     = { fg = '#455574' },
          ['CmpItemKindDefault']        = { fg = '#dd9046' },
          ['CmpItemKindSnippet']        = { fg = '#f65866' },
          ['CmpItemKindKeyword']        = { fg = '#bfbd5d' },
          ['CmpItemKindText']           = { fg = '#93a4c3' },
          ['CmpItemKindCopilot']        = { fg = '#6CC644' },
          ['RainbowParenBlue']          = { fg = colors.blue },
          ['RainbowParenCyan']          = { fg = colors.cyan },
          ['RainbowParenGreen']         = { fg = colors.green },
          ['RainbowParenOrange']        = { fg = colors.orange },
          ['RainbowParenRed']           = { fg = colors.red },
          ['RainbowParenPurple']        = { fg = colors.purple },
          ['RainbowParenYellow']        = { fg = colors.yellow },
          ['RainbowIndentBlue']         = { fg = colors.dimmed_blue },
          ['RainbowIndentCyan']         = { fg = colors.dimmed_cyan },
          ['RainbowIndentGreen']        = { fg = colors.dimmed_green },
          ['RainbowIndentOrange']       = { fg = colors.dimmed_orange },
          ['RainbowIndentRed']          = { fg = colors.dimmed_red },
          ['RainbowIndentPurple']       = { fg = colors.dimmed_purple },
          ['RainbowIndentYellow']       = { fg = colors.dimmed_yellow },
          ['Winbar']                    = { fmt = 'none' },
          ['NormalDarker']              = { bg = '#141b24', fg = '#93a4c3' },
          ['SignColumnDarker']          = { bg = '#141b24', fg = '#93a4c3' },
          ['EndOfBufferDarker']         = { bg = '#141b24', fg = '#141b24' },
          ['WinSeparatorDarker']        = { bg = '#141b24', fg = '#2a324a' },
          ['CursorLine']                = { bg = '#21283b' },
          ['CursorLineNR']              = { bg = '#21283b', fmt = 'bold' },
          ['CursorColumn']              = { bg = '#21283b' },
          ['ColorColumn']               = { bg = '#21283b' },
          ['Warning']                   = { bg = '#443333' },
          ['Error']                     = { bg = '#512121' },
          ['Visual']                    = { bg = '#401437' },
          ['DiagnosticVirtualTextHint'] = { fg = '#1b6a73', bg = 'NONE' },
          ['DiagnosticVirtualTextInfo'] = { fg = '#1b6a73', bg = 'NONE' },
          ['DiagnosticUnderlineError']  = { bg = '#512121', fmt = 'NONE' },
          ['DiagnosticUnderlineWarn']   = { bg = '#443333', fmt = 'NONE' },
          ['DiagnosticUnderlineInfo']   = { bg = 'NONE', fmt = 'NONE' },
          ['DiagnosticUnderlineHint']   = { bg = 'NONE', fmt = 'NONE' },
          ['FoldColumn']                = { bg = '#1a212e', fg = '#455574' },
          ['SignColumn']                = { fg = '#21283b' },
          ['CursorLineSign']            = { fg = '#21283b' },
          ['IncSearch']                 = { fg = '#FF0000', bg = 'NONE', fmt = 'bold,nocombine' },
          ['CurSearch']                 = { fg = '#FF0000', bg = 'NONE', fmt = 'bold,nocombine' },
          ['Search']                    = { fg = '#FFFFFF', bg = 'NONE', fmt = 'bold,nocombine' },
        },
      })
      require('onedark').load()

      vim.cmd [[
        highlight! link NormalFloat Normal
        highlight! link FloatBorder Normal
        highlight! NormalDarker       guibg=#141b24 guifg=#93a4c3
        highlight! SignColumnDarker   guibg=#141b24 guifg=#93a4c3
        highlight! EndOfBufferDarker  guifg=#141b24 guibg=#141b24
        highlight! WinSeparatorDarker guifg=#2a324a guibg=#141b24
        highlight! link WhichKeyNormal NormalDarker
        highlight! link WhichKeyBorder NormalDarker
        highlight! link LazyNormal NormalDarker
      ]]

      vim.cmd [[
        augroup make_panels_darker
          autocmd!
          autocmd FileType Mundo setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker
          autocmd FileType MundoDiff setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker
          autocmd FileType floaterm setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker
          autocmd FileType help setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker
          autocmd FileType lspinfo setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker
          autocmd FileType mason setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker
          autocmd FileType Trouble setlocal colorcolumn=
        augroup END

        augroup treesitter_hl_overrides
          autocmd!
          highlight! @error.ruby guibg=NONE guifg=NONE gui=NONE
          highlight! link @parameter   @variable.builtin
          highlight! link @tag.attribute @boolean
          highlight! link @tag Special
          highlight! link @tag.delimiter Special
          highlight! link @keyword.function @keyword
          highlight! link htmlBold Normal
          highlight! link @lsp.type.type @type
          highlight! link @lsp.type.macro @macro
          highlight! link @lsp.type.method @method
          highlight! link @lsp.type.comment @comment
          highlight! link @lsp.type.function @function
          highlight! link @lsp.type.property @property
          highlight! link @lsp.type.namespace @namespace
          highlight! link @lsp.type.parameter @parameter
          highlight! link @string.special.url.html Normal
          highlight! link @variable.member.ruby Special
          highlight! link @variable.parameter.ruby Special
          highlight! link @string.special.symbol.ruby Constant
          highlight! link @function.builtin.ruby @keyword
          highlight! link @tag.delimiter.tsx Normal
          highlight! link @tag.tsx Type
          highlight! link @lsp.typemod.function.declaration.typescriptreact @type
          highlight! link @lsp.typemod.function.readonly.typescriptreact @type
          highlight! link @lsp.type.variable.typescriptreact Special
          highlight! link @lsp.typemod.variable.readonly.javascript @type
          highlight! link @tag.delimiter.javascript Normal
          highlight! link @lsp.type.variable.javascript Special
          highlight! link @tag.javascript @type
        augroup END
      ]]
    end
  },
}
