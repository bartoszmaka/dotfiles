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
          ['CmpItemAbbr']               = { fg = '#6c7d9c' },
          ['CmpItemAbbrMatch']          = { fg = '#f2cc81' },
          ['CmpItemAbbrMatchFuzzy']     = { fg = '#f2cc81', fmt = 'none' },
          ['CmpItemAbbrDeprecated']     = { fg = '#455574' },
          ['CmpItemKindDefault']        = { fg = '#dd9046' },
          ['CmpItemKindSnippet']        = { fg = '#f65866' },
          ['CmpItemKindKeyword']        = { fg = '#bfbd5d' },
          ['CmpItemKindText']           = { fg = '#93a4c3' },
          ['CmpItemKindCopilot']        = { fg = '#6CC644' },
          ['IlluminatedWordText']       = { fmt = 'none', bg = colors.bg3 },
          ['IlluminatedWordRead']       = { fmt = 'none', bg = colors.bg2 },
          ['illuminatedwordwrite']      = { fmt = 'none', bg = colors.diff_add },
          ['RainbowColOrange']          = { fg = '#dd9046' },
          ['RainbowColGreen']           = { fg = '#8bcd5b' },
          ['RainbowColViolet']          = { fg = '#c75ae8' },
          ['RainbowColCyan']            = { fg = '#34bfd0' },
          ['RainbowColRed']             = { fg = '#f65866' },
          ['RainbowColYellow']          = { fg = '#efbd5d' },
          ['RainbowColBlue']            = { fg = '#41a7fc' },
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
          -- ['Hlargs']                    = { bg = 'none', fg = 'none', fmt = 'italic' }
          ['IncSearch']                 = { fg = '#FF0000', bg = 'NONE', fmt = 'bold,nocombine' },
          ['CurSearch']                 = { fg = '#FF0000', bg = 'NONE', fmt = 'bold,nocombine' },
          ['Search']                    = { fg = '#FFFFFF', bg = 'NONE', fmt = 'bold,nocombine' },
        },
      })
      -- require('onedark').load()

      vim.cmd [[
        augroup graphql_syntax_fix
        autocmd!
        autocmd FileType javascript highlight! link graphqlStructure Constant
        autocmd FileType javascript highlight! link graphqlVariable Type
        autocmd FileType javascript highlight! link graphqlName String
        autocmd FileType javascript highlight! link graphqlType Constant
        autocmd FileType javascript highlight! link graphqlStructure Label
        autocmd FileType javascript highlight! link TSTag TSConstructor
        augroup END

        augroup make_panels_darker
        autocmd!
        highlight! link NormalFloat Normal
        highlight! link FloatBorder Normal
        highlight! link WhichKeyFloat NormalDarker
        highlight! link WhichKeyBorder NormalDarker
        autocmd FileType ctrlsf setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker
        autocmd FileType help setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker
        autocmd FileType floaterm setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker
        autocmd FileType Trouble setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker
        autocmd FileType Trouble setlocal colorcolumn=
        autocmd FileType Mundo setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker
        autocmd FileType MundoDiff setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker
        autocmd FileType vista_kind setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker
        autocmd FileType lspsagaoutline setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker
        autocmd FileType sagaoutline setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker
        augroup END

        augroup hlargs_overrides
        autocmd!
          highlight! Hlargs guibg=none guifg=none gui=italic
        augroup END
      ]]
    end
  },
}
