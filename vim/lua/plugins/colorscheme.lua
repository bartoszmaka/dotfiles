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
          ['SignColumn']                = { fg = '#21283b' },
          ['CursorLineSign']            = { fg = '#21283b' },
          -- ['Hlargs']                    = { bg = 'none', fg = 'none', fmt = 'italic' }
          ['IncSearch']                 = { fg = '#FF0000', bg = 'NONE', fmt = 'bold,nocombine' },
          ['CurSearch']                 = { fg = '#FF0000', bg = 'NONE', fmt = 'bold,nocombine' },
          ['Search']                    = { fg = '#FFFFFF', bg = 'NONE', fmt = 'bold,nocombine' },
        },
      })
      require('onedark').load()
      vim.cmd [[
        highlight! FoldColumn guibg=#1a212e guifg=#455574
      ]]
    end
  },
}

-- highlight! IblRainbowColOrange guibg=#dd9046
-- highlight! IblRainbowColGreen guibg=#8bcd5b
-- highlight! IblRainbowColViolet guibg=#c75ae8
-- highlight! IblRainbowColCyan guibg=#34bfd0
-- highlight! IblRainbowColRed guibg=#f65866
-- highlight! IblRainbowColYellow guibg=#efbd5d
-- highlight! IblRainbowColBlue guibg=#41a7fc
-- Dimmed 70%
-- highlight! IblRainbowColOrange guifg=#492b0d
-- highlight! IblRainbowColGreen guifg=#284414
-- highlight! IblRainbowColViolet guifg=#430b54
-- highlight! IblRainbowColCyan guifg=#0e3a3f
-- highlight! IblRainbowColRed guifg=#5f050d
-- highlight! IblRainbowColYellow guifg=#5a3e08
-- highlight! IblRainbowColBlue guifg=#01335d
