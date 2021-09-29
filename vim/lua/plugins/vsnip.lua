vim.g.vsnip_snippet_dir = vim.fn.expand("$HOME/.repos/dotfiles/vim/vsnip")

vim.g.vsnip_filetypes = {
  javascript = {'javascriptreact'},
  typescript = {'javascript', 'javascriptreact', 'typescriptreact'},
  javascriptreact = {'javascript'},
  typescriptreact = {'typescript, javascriptreact, javascript'}
}

vim.cmd [[
imap <expr> <C-e> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-e>'
smap <expr> <C-e> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-e>'
imap <expr> <C-b> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>'
smap <expr> <C-b> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>'
]]
