vim.g.did_load_filetypes = 1

require('filetype').setup({
  extensions = {
    yml = 'yaml'
  },
  overrides = {
    literal = {
      gitconfig = 'gitconfig',
    },
    complex = {
      ['%.env%.*'] = 'sh',
      ['.pryrc'] = 'ruby',
    },
  },
})
