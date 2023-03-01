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

  augroup color_current_line_in_insert
    autocmd!
    autocmd InsertEnter * highlight! CursorLine   guibg=#512121
    autocmd InsertEnter * highlight! CursorLineNR guibg=#512121
    autocmd InsertLeave * highlight! CursorLine   guibg=#21283b
    autocmd InsertLeave * highlight! CursorLineNR guibg=#21283b
  augroup END

  augroup make_panels_darker
    autocmd!
    highlight! NormalFloat       guibg=#141b24 guifg=#93a4c3
    highlight! FloatBorder       guibg=#141b24 guifg=#93a4c3
    highlight! NormalDarker      guibg=#141b24 guifg=#93a4c3
    highlight! SignColumnDarker  guibg=#141b24 guifg=#93a4c3
    highlight! EndOfBufferDarker guifg=#141b24 guibg=#141b24
    autocmd FileType ctrlsf setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker
    autocmd FileType floaterm setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker
    autocmd FileType Trouble setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker
    autocmd FileType Trouble setlocal colorcolumn=
    autocmd FileType Mundo setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker
    autocmd FileType MundoDiff setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker
    autocmd FileType vista_kind setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker
    autocmd FileType lspsagaoutline setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker
  augroup END

  augroup illuminate_overrides
    autocmd!
    highlight! illuminatedWord guibg=#314365
    highlight! illuminatedCurWord guibg=#314365 gui=bold
    highlight! link IlluminatedWordRead illuminatedWord
    highlight! link IlluminatedWordWrite illuminatedWord
    highlight! link IlluminatedWordText None
  augroup END

  augroup gitsigns_overrides
    autocmd!
    highlight! GitSignsChange guifg=#f2cc81
    highlight! GitSignsChangeNr guifg=#f2cc81
    highlight! GitSignsChangeLn guifg=#f2cc81
  augroup END

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
  augroup END

  augroup treesitter_overrides
    autocmd!
    highlight! link @parameter   @variable.builtin
    highlight! @constructor      gui=NONE
    highlight! TSKeywordFunction gui=NONE
    highlight! TSConstructor     gui=NONE
    highlight! TSInclude         gui=italic
    highlight! TSKeyword         gui=italic
    highlight! TSKeywordFunction gui=italic
    highlight! TSVariableBuiltin gui=italic
    highlight! TSConditional     gui=italic
    highlight! link vueTSMethod TSBoolean
    highlight! link TSTagAttribute TSBoolean
    highlight! link @tag.attribute @boolean
    highlight! link @tag Special
    highlight! link @tag.delimiter Special
    highlight! link htmlBold Normal
    highlight! link htmlBoldItalic Normal
    highlight! link htmlBoldItalicUnderline Normal
    highlight! link tsxTSTag TSConstructor
  augroup END

  augroup color_scheme_tweaks
    autocmd!
    highlight! DiffChange      guibg=#2e2e1a guifg=NONE gui=NONE
    highlight! DiffText        guibg=#3e3e23 guifg=NONE gui=NONE
    highlight! DiffAdd         guibg=#1a2e1b guifg=NONE gui=NONE
    highlight! DiffDelete      guibg=#2e201a guifg=NONE gui=NONE
    highlight! CursorLine      guibg=#21283b
    highlight! CursorLineNR    guibg=#21283b gui=bold
    highlight! CursorColumn    guibg=#21283b
    highlight! ColorColumn     guibg=#21283b
    highlight! Warning         guibg=#443333
    highlight! Error           guibg=#512121
    highlight! Visual          guibg=#401437
    highlight! IncSearch       guifg=#FF0000 guibg=NONE gui=bold,nocombine
    highlight! Search          guifg=#FFFFFF guibg=NONE gui=bold,nocombine
    " highlight! Comment         gui=italic

    highlight! DiagnosticVirtualTextHint guifg=#1b6a73 guibg=NONE
    highlight! DiagnosticVirtualTextInfo guifg=#1b6a73 guibg=NONE

    highlight! DiagnosticUnderlineError  guibg=#512121 gui=NONE
    highlight! DiagnosticUnderlineWarn   guibg=#443333 gui=NONE
    highlight! DiagnosticUnderlineInfo   guibg=NONE gui=NONE
    highlight! DiagnosticUnderlineHint   guibg=NONE gui=NONE
  augroup END

  augroup conflict_marker_overrides
    autocmd!
    highlight! ConflictMarkerBegin  guibg=#283c34
    highlight! ConflictMarkerOurs  guibg=#1a2e1b
    highlight! ConflictMarkerTheirs  guibg=#2a324a
    highlight! ConflictMarkerEnd  guibg=#2f628e
    highlight! ConflictMarkerCommonAncestorsHunk  guibg=#382c34
  augroup END

  augroup barbar_overrides
    autocmd!
    highlight! BufferCurrent        guifg=#f2cc81 guibg=#1a212e
    highlight! BufferCurrentMod     guifg=#8bcd5b guibg=#1a212e
    highlight! BufferVisible        guifg=#93a4c3 guibg=#1a212e
    highlight! BufferVisibleMod     guifg=#1b6a73 guibg=#1a212e
    highlight! BufferVisibleSign    guifg=#93a4c3 guibg=#1a212e
    highlight! BufferInactive       guifg=#93a4c3 guibg=#2a324a
    highlight! BufferInactiveMod    guifg=#34bfd0 guibg=#2a324a
    highlight! BufferInactiveSign   guifg=#93a4c3 guibg=#2a324a
  augroup END

  augroup hlslens_overrides
    autocmd!
    highlight! default link HlSearchNear IncSearch
    highlight! default link HlSearchLens Comment
    highlight! default link HlSearchLensNear IncSearch
    highlight! default link HlSearchFloat IncSearch
  augroup END

  augroup indent_blankline_overrides
    autocmd!
    highlight! IndentBlanklineChar guifg=#283347
    highlight! IndentBlanklineContextChar guifg=#455574 gui=nocombine
  augroup END

  augroup matchup_overrides
    autocmd!
    highlight! MatchParen        guifg=NONE    guibg=NONE gui=bold,underline
    highlight! MatchParenCur     guifg=NONE    guibg=NONE gui=bold,underline
  augroup END

  augroup hop_overrides
    autocmd!

    highlight! HopNextKey guibg=#1a212e guifg=#efbd5d
    highlight! HopNextKey1 guibg=#1a212e guifg=#efbd5d
    highlight! HopNextKey2 guibg=#1a212e guifg=#dd9046
    highlight! HopUnmatched guibg=#1a212e
  augroup END
]]
