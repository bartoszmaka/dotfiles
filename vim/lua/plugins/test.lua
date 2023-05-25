return {
  'janko/vim-test',
  config = function()
    nmap = require('helper').nmap

    if vim.fn.exists('$TMUX') == 1 then
      vim.g["test#strategy"] = "vimux"
      vim.g.VimuxHeight = 40
      -- vim.cmd[[
      --   let g:VimuxHeight = "40"
      --   let test#strategy = "vimux"
      -- ]]
    elseif vim.fn.exists('$KITTY_WINDOW_ID') == 1 then
      vim.g["test#strategy"] = "kitty"
      -- vim.cmd[[

      -- ]]
    elseif vim.fn.has('gui_running') or vim.fn.has('goneovim_running') then
      vim.g["test#strategy"] = "floaterm"
      -- vim.cmd[[
      --   let test#strategy = "floaterm"
      -- ]]
    end

    vim.cmd [[
  let test#ruby#cucumber#executable = 'bundle exec cucumber'
  let test#ruby#rspec#executable = 'bundle exec rspec'
]]

    nmap('TT', ':TestNearest<CR>')
    nmap('<leader>tt', ':TestNearest<CR>')
    nmap('TF', ':TestFile<CR>')
    nmap('<leader>tf', ':TestFile<CR>')
  end,
}
