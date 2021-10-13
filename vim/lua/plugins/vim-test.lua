vim.cmd[[
  let test#strategy = "vimux"
  if has('gui_running') || has('goneovim_running')
    let test#strategy = "floaterm"
  end
  let test#ruby#cucumber#executable = 'bundle exec cucumber'
  let test#ruby#rspec#executable = 'bundle exec rspec'
  nmap TT :TestNearest<CR>
  nmap <leader>tt :TestNearest<CR>
  nmap TF :TestFile<CR>
  nmap <leader>tf :TestFile<CR>
  " vimux
  let g:VimuxHeight = "40"
]]
