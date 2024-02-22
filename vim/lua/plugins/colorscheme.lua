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
          DiffChange                = { bg = colors.diff_change, fg = "none" },
          DiffText                  = { bg = colors.diff_text, fg = "none" },
          DiffAdd                   = { bg = colors.diff_add, fg = "none" },
          DiffDelete                = { bg  = colors.diff_delete, fg = "none" },
          ['@boolean']              = { fmt = 'italic' },
          ['@constant.builtin']     = { fmt = 'italic', fg           = colors.red },
          ['@include']              = { fmt = 'italic' },
          ['@keyword']              = { fmt = 'italic' },
          ['@keyword.function']     = { fmt = 'italic' },
          ['@variable.builtin']     = { fmt = 'italic' },
          ['@conditional']          = { fmt = 'none' },
          ['@constructor']          = { fmt = 'none' },
          ['@lsp.type.variable']    = { fmt = 'none' },
          ['CmpItemAbbr']           = { fg  = '#6c7d9c' },
          ['CmpItemAbbrMatch']      = { fg  = '#f2cc81' },
          ['CmpItemAbbrMatchFuzzy'] = { fg  = '#f2cc81', fmt = 'none' },
          ['CmpItemAbbrDeprecated'] = { fg  = '#455574' },
          ['CmpItemKindDefault']    = { fg  = '#dd9046' },
          ['CmpItemKindSnippet']    = { fg  = '#f65866' },
          ['CmpItemKindKeyword']    = { fg  = '#bfbd5d' },
          ['CmpItemKindText']       = { fg  = '#93a4c3' },
          ['CmpItemKindCopilot']    = { fg  = '#6CC644' },
          ['IlluminatedWordText']   = { fmt = 'none', bg             = colors.bg3 },
          ['IlluminatedWordRead']   = { fmt = 'none', bg             = colors.bg2 },
          ['illuminatedwordwrite']  = { fmt = 'none', bg             = colors.diff_add },
          -- ['CmpItemKind']           = { fmt = 'reverse' },
          -- ['CmpItemKindKey']        = { fmt = 'reverse' },
          -- ['CmpItemKindEnum']       = { fmt = 'reverse' },
          -- ['CmpItemKindFile']       = { fmt = 'reverse' },
          -- ['CmpItemKindNull']       = { fmt = 'reverse' },
          -- ['CmpItemKindUnit']       = { fmt = 'reverse' },
          -- ['CmpItemKindArray']      = { fmt = 'reverse' },
          -- ['CmpItemKindClass']      = { fmt = 'reverse' },
          -- ['CmpItemKindColor']      = { fmt = 'reverse' },
          -- ['CmpItemKindEvent']      = { fmt = 'reverse' },
          -- ['CmpItemKindField']      = { fmt = 'reverse' },
          -- ['CmpItemKindValue']      = { fmt = 'reverse' },
          -- ['CmpItemKindFolder']     = { fmt = 'reverse' },
          -- ['CmpItemKindMethod']     = { fmt = 'reverse' },
          -- ['CmpItemKindModule']     = { fmt = 'reverse' },
          -- ['CmpItemKindNumber']     = { fmt = 'reverse' },
          -- ['CmpItemKindObject']     = { fmt = 'reverse' },
          -- ['CmpItemKindString']     = { fmt = 'reverse' },
          -- ['CmpItemKindStruct']     = { fmt = 'reverse' },
          -- ['CmpItemKindBoolean']    = { fmt = 'reverse' },
          -- ['CmpItemKindPackage']    = { fmt = 'reverse' },
          -- ['CmpItemKindConstant']   = { fmt = 'reverse' },
          -- ['CmpItemKindFunction']   = { fmt = 'reverse' },
          -- ['CmpItemKindOperator']   = { fmt = 'reverse' },
          -- ['CmpItemKindProperty']   = { fmt = 'reverse' },
          -- ['CmpItemKindVariable']   = { fmt = 'reverse' },
          -- ['CmpItemKindInterface']  = { fmt = 'reverse' },
          -- ['CmpItemKindNamespace']  = { fmt = 'reverse' },
          -- ['CmpItemKindReference']  = { fmt = 'reverse' },
        },
      })
      require('onedark').load()
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
