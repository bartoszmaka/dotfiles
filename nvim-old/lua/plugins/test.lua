return {
  'janko/vim-test',
  config = function()
    local nmap = require('helper').nmap

    vim.g["test#preserve_screen"] = 1
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

    nmap('<leader>tt', ':TestNearest<CR>')
    nmap('<leader>tf', ':TestFile<CR>')
  end,
}
