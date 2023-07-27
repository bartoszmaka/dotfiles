return {
  'nathom/filetype.nvim',
  config = function()
    vim.g.did_load_filetypes = 1

    require('filetype').setup({
      overrides = {
        extensions = {
          yml = 'yaml',
          sh = 'sh',
          snippets = 'snippets'
        },
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
