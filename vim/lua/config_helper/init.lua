local M = {}

function M.map(from, to, mode, opts)
  local options = {noremap = true}
  mode = mode or ''
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, from, to, options)
end

function M.remap(from, to, mode, opts)
  opts = opts or {}
  mode = mode or ''
  vim.api.nvim_set_keymap(mode, from, to, opts)
end

function M.unmap(keymapping, mode)
  mode = mode or ''
  vim.api.nvim_del_keymap(mode, keymapping)
end

function M.nnoremap(from, to, opts) return M.map(from, to, 'n',  opts) end
function M.tnoremap(from, to, opts) return M.map(from, to, 't',  opts) end
function M.inoremap(from, to, opts) return M.map(from, to, 'i',  opts) end
function M.vnoremap(from, to, opts) return M.map(from, to, 'v',  opts) end
function M.cnoremap(from, to, opts) return M.map(from, to, 'c',  opts) end
function M.snoremap(from, to, opts) return M.map(from, to, 's',  opts) end
function M.nmap(from, to, opts) return M.remap(from, to, 'n',  opts) end
function M.tmap(from, to, opts) return M.remap(from, to, 't',  opts) end
function M.imap(from, to, opts) return M.remap(from, to, 'i',  opts) end
function M.vmap(from, to, opts) return M.remap(from, to, 'v',  opts) end
function M.cmap(from, to, opts) return M.remap(from, to, 'c',  opts) end
function M.smap(from, to, opts) return M.remap(from, to, 's',  opts) end

local vim_variable_scopes = { g = vim.api.nvim_set_var }
function M.let(scope, key, value)
  vim_variable_scopes[scope](key, value)
end

function M.is_buffer_empty()
  return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

function M.has_width_gt(cols)
  return vim.fn.winwidth(0) / 2 > cols
end

M.colors = require('config_helper.colors')
M.throttle = require('config_helper.throttle')
M.timeago = require('config_helper.timeago')
M.statusline = require('config_helper.statusline_segments')
return M
