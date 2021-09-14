vim.cmd [[
  let g:anzu_status_format = "%#Search#▶%p◀ (%i/%l)"
  nmap n <Plug>(anzu-n-with-echo)zz<Plug>(anzu-echo-search-status)
  nmap N <Plug>(anzu-N-with-echo)zz<Plug>(anzu-echo-search-status)
  nmap * <Plug>(anzu-star-with-echo)zz<Plug>(anzu-echo-search-status)
  nmap # <Plug>(anzu-sharp-with-echo)zz<Plug>(anzu-echo-search-status)
]]
