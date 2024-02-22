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
    highlight! NormalFloat       guibg=#141b24 guifg=#93a4c3
    highlight! FloatBorder       guibg=#141b24 guifg=#93a4c3
    highlight! NormalDarker      guibg=#141b24 guifg=#93a4c3
    highlight! SignColumnDarker  guibg=#141b24 guifg=#93a4c3
    highlight! EndOfBufferDarker guifg=#141b24 guibg=#141b24
    autocmd FileType ctrlsf setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker
    autocmd FileType help setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker
    autocmd FileType floaterm setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker
    autocmd FileType Trouble setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker
    autocmd FileType fzf setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker
    autocmd FileType Trouble setlocal colorcolumn=
    autocmd FileType Mundo setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker
    autocmd FileType MundoDiff setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker
    autocmd FileType vista_kind setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker
    autocmd FileType lspsagaoutline setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker
    autocmd FileType lspsagaoutline setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker
  augroup END

  augroup treesitter_overrides
    autocmd!
    highlight! @error.ruby guibg=NONE guifg=NONE gui=NONE

    highlight! link @parameter   @variable.builtin
    highlight! link vueTSMethod TSBoolean
    highlight! link TSTagAttribute TSBoolean
    highlight! link @tag.attribute @boolean
    highlight! link @tag Special
    highlight! link @tag.delimiter Special
    highlight! link @keyword.function @keyword
    highlight! link htmlBold Normal
    highlight! link htmlBoldItalic Normal
    highlight! link htmlBoldItalicUnderline Normal
    highlight! link tsxTSTag TSConstructor
    highlight! link tsxTSTag TSConstructor
    highlight! link @lsp.type.type @type
    highlight! link @lsp.type.macro @macro
    highlight! link @lsp.type.method @method
    highlight! link @lsp.type.comment @comment
    highlight! link @lsp.type.function @function
    highlight! link @lsp.type.property @property
    highlight! link @lsp.type.namespace @namespace
    highlight! link @lsp.type.parameter @parameter
    highlight! link @lsp.typemod.function.declaration.typescriptreact @type
    highlight! link @lsp.typemod.function.readonly.typescriptreact @type
    highlight! link @lsp.typemod.variable.readonly.javascript @type
    highlight! link @lsp.typemod.variable.readonly.javascript @type
    highlight! link @variable.member.ruby Special
    highlight! link @variable.parameter.ruby Special
    highlight! link @string.special.symbol.ruby Constant

    " highlight! link @type.javascript @type set prio to 200
  augroup END

  augroup color_scheme_tweaks
    autocmd!
    " highlight! DiffChange      guibg=#2e2e1a guifg=NONE gui=NONE
    " highlight! DiffText        guibg=#3e3e23 guifg=NONE gui=NONE
    " highlight! DiffAdd         guibg=#1a2e1b guifg=NONE gui=NONE
    " highlight! DiffDelete      guibg=#2e201a guifg=NONE gui=NONE
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

  augroup hlargs_overrides
    autocmd!
    highlight! Hlargs guibg=none guifg=none gui=italic
  augroup END
]]
