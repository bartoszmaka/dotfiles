return {
  'janko/vim-test',
  config = function()
    local nmap = require('helper').nmap
    local h2_root = '$HOME/projects/work/h2'

    local function set_rspec_executable()
      local cwd = vim.fn.getcwd()
      local root = vim.fs.root(cwd, { '.git' }) or cwd

      if root == h2_root then
        vim.g['test#ruby#rspec#executable'] = 'ht rspec'
      else
        vim.g['test#ruby#rspec#executable'] = 'bundle exec rspec'
      end
    end

    vim.g["test#preserve_screen"] = 1
    if vim.fn.exists('$TMUX') == 1 then
      vim.g["test#strategy"] = "vimux"
      vim.g.VimuxHeight = 40
    elseif vim.fn.exists('$KITTY_WINDOW_ID') == 1 then
      vim.g["test#strategy"] = "kitty"
    elseif vim.fn.has('gui_running') or vim.fn.has('goneovim_running') then
      vim.g["test#strategy"] = "floaterm"
    end

    vim.cmd [[
      let test#ruby#cucumber#executable = 'bundle exec cucumber'
    ]]

    set_rspec_executable()
    vim.api.nvim_create_autocmd({ 'DirChanged' }, {
      callback = set_rspec_executable,
    })

    nmap('<leader>tt', ':TestNearest<CR>')
    nmap('<leader>tf', ':TestFile<CR>')
  end,
}
