vim.g.mapleader = ' '
vim.o.termguicolors = true

vim.cmd [[
  let g:python3_host_prog = '/Users/bartoszmaka/.asdf/shims/python3'
  let g:python2_host_prog = '/Users/bartoszmaka/.asdf/shims/python2'
]]

local enabled_plugins = {
  'onedark.nvim',
  'nvim-web-devicons',
  'plenary.nvim',
  'filetype.nvim',
  'vim-projectionist',
  'splitjoin.vim',
  'neo-tree.nvim',
  'nui.nvim',
  'nvim-window-picker',
  'barbar.nvim',
  'fzf',
  'fzf.vim',
  'fzf-mru.vim',
  'fzf-lua',
  'vim-surround',
  'vim-repeat',
  'vim-commentary',
  'lualine.nvim',
  'vim-abolish',
  'nvim-treesitter',
  'nvim-treesitter-context',
  'hlargs.nvim',

  'nvim-cmp',
  'copilot.lua',
  'copilot-cmp',
}

require('disable_builtin')
require('setup_lazy')
require('lazy').setup({
  -- root = vim.fn.stdpath("data") .. "/lazy_minimal", -- directory where plugins will be installed
  -- lockfile = vim.fn.stdpath("config") .. "/lazy_minimal-lock.json", -- lockfile generated after running update.
  spec = { import = 'plugins'},
  install = {
    colorscheme = { 'onedark' },
  },
  defaults = {
    cond = function(lazy_plugin)
      for key, value in pairs(enabled_plugins) do
        if value == lazy_plugin.name then return true end
      end

      return false
    end
  }
})

require('options')
require('mappings')
require('abbrevations')
require('autocmds')
require('colorscheme_overrides')
require('gui')
-- local loadedLsp, _ = pcall(require, 'lsp')
-- if not loadedLsp then print('Error in lsp config') end
