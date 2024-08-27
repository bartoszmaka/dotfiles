local function augroup(name)
  return vim.api.nvim_create_augroup("autocmds_lua" .. name, { clear = true })
end

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }

vim.cmd [[
  command! CopyPath execute 'let @+ = expand("%:.")'
  nnoremap <leader>cp :CopyPath<CR>
]]

vim.cmd [[
  augroup fix_autotag_for_eruby_not_setting_up_for_some_reason
    autocmd!
    autocmd FileType eruby lua require('nvim-ts-autotag').setup()
    autocmd FileType * call v:lua.require('nvim-ts-autotag.internal').attach()
    autocmd BufDelete * lua require('nvim-ts-autotag.internal').detach(vim.fn.expand('<abuf>'))
  augroup END

  augroup hlargs_overrides
    autocmd!
    highlight! Hlargs guibg=none guifg=none gui=italic
  augroup END

  augroup treesitter_overrides
    autocmd!
    autocmd FileType javascript highlight! link graphqlStructure Constant
    autocmd FileType javascript highlight! link graphqlVariable Type
    autocmd FileType javascript highlight! link graphqlName String
    autocmd FileType javascript highlight! link graphqlType Constant
    autocmd FileType javascript highlight! link graphqlStructure Label
    autocmd FileType javascript highlight! link TSTag TSConstructor

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
    highlight! link @lsp.type.type @type
    highlight! link @lsp.type.macro @macro
    highlight! link @lsp.type.method @method
    highlight! link @lsp.type.comment @comment
    highlight! link @lsp.type.function @function
    highlight! link @lsp.type.property @property
    highlight! link @lsp.type.namespace @namespace
    highlight! link @lsp.type.parameter @parameter

    " html | eruby"
    highlight! link @string.special.url.html Normal

    " ruby
    highlight! link @variable.member.ruby Special
    highlight! link @variable.parameter.ruby Special
    highlight! link @string.special.symbol.ruby Constant
    highlight! link @function.builtin.ruby @keyword

    " typescript
    highlight! link @tag.delimiter.tsx Normal
    highlight! link @tag.tsx Type
    highlight! link @lsp.typemod.function.declaration.typescriptreact @type
    highlight! link @lsp.typemod.function.readonly.typescriptreact @type
    highlight! link @lsp.type.variable.typescriptreact Special

    " javascript
    highlight! link @lsp.typemod.variable.readonly.javascript @type
    highlight! link @lsp.typemod.variable.readonly.javascript @type
    highlight! link @tag.delimiter.javascript Normal
    highlight! link @lsp.type.variable.javascript Special
    highlight! link @tag.javascript @type
  augroup END
  ]]

vim.api.nvim_create_autocmd({ 'BufEnter','BufNewFile','BufWritePost' }, {
  group = augroup("tmux_rename_on_enter"),
  callback = function ()
    vim.system({"tmux", "rename-window", vim.fn.expand("%:.")})
  end
  }
)

vim.api.nvim_create_autocmd({ "VimLeave" }, {
  group = augroup("tmux_rename_on_exit"),
  callback = function ()
    vim.system({"tmux", "rename-window", vim.uv.cwd()})
  end
  }
)
