vim.g.indentline_char = '│'
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_context_patterns = {
	'class',
  'module',
	'function',
	'method',
	'^if',
	'^while',
	'^typedef',
	'^for',
	'^object',
	'^table',
	'block',
	'arguments',
	'typedef',
	'while',
	'hash',
	'array',
	'argument_list',
	'^public',
	'return',
	'if_statement',
	'else_clause',
	'jsx_element',
	'jsx_self_closing_element',
	'try_statement',
	'catch_clause',
	'import_statement'
}
vim.cmd[[
highlight! IndentBlanklineChar guifg=#283347
highlight! IndentBlanklineContextChar guifg=#455574 gui=nocombine
  nnoremap <leader>it :IndentBlanklineToggle<CR>
]]
