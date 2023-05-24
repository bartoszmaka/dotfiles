return {
  'nathom/filetype.nvim',
  config = function()
    vim.g.did_load_filetypes = 1

    require('filetype').setup({
      extensions = {
        yml = 'yaml',
        sh = 'sh'
      },
      overrides = {
        literal = {
          gitconfig = 'gitconfig',
          zshrc = 'zsh',
        },
        complex = {
          ['*.sh'] = 'sh',
          ['%.env%.*'] = 'sh',
          ['%.yml'] = 'yaml',
          ['.pryrc'] = 'ruby',
        },
      },
    })
  end,
}
