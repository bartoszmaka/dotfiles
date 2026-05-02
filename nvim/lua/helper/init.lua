local M = {}

M.colors = require('helper.colors')
M.symbols = require('helper.symbols')

function M.map(from, to, mode, opts)
  local options = { noremap = true }
  mode = mode or ''
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, from, to, options)
end

function M.remap(from, to, mode, opts)
  opts = opts or {}
  mode = mode or ''
  vim.keymap.set(mode, from, to, opts)
end

function M.unmap(keymapping, mode)
  mode = mode or ''
  vim.api.nvim_del_keymap(mode, keymapping)
end

function M.nnoremap(from, to, opts) return M.map(from, to, 'n', opts) end
function M.tnoremap(from, to, opts) return M.map(from, to, 't', opts) end
function M.inoremap(from, to, opts) return M.map(from, to, 'i', opts) end
function M.vnoremap(from, to, opts) return M.map(from, to, 'v', opts) end
function M.cnoremap(from, to, opts) return M.map(from, to, 'c', opts) end
function M.snoremap(from, to, opts) return M.map(from, to, 's', opts) end

function M.nmap(from, to, opts) return M.remap(from, to, 'n', opts) end
function M.tmap(from, to, opts) return M.remap(from, to, 't', opts) end
function M.imap(from, to, opts) return M.remap(from, to, 'i', opts) end
function M.vmap(from, to, opts) return M.remap(from, to, 'v', opts) end
function M.cmap(from, to, opts) return M.remap(from, to, 'c', opts) end
function M.smap(from, to, opts) return M.remap(from, to, 's', opts) end

function M.bool2str(bool) return bool and 'on' or 'off' end

function M.is_buffer_empty()
  return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

function M.has_width_gt(cols)
  return vim.fn.winwidth(0) / 2 > cols
end

function M.set_contains(set, val)
  for _, value in pairs(set) do
    if value == val then return true end
  end
  return false
end

function M.safe_require(package_name)
  local loaded, package = pcall(require, package_name)
  if not loaded then print('Error loading ' .. package_name) end
  return package
end

function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

function M.fg(name)
  local hl = vim.api.nvim_get_hl(0, { name = name })
  local fg = hl and hl.fg
  return fg and { fg = string.format('#%06x', fg) }
end

function M.keys(object)
  local result = {}
  for key, _ in pairs(object) do
    table.insert(result, key)
  end
  return result
end

function M.get(object, path)
  local value = object
  local segments = {}
  for segment in string.gmatch(path, '[^%.]+') do
    table.insert(segments, segment)
  end
  for _, segment in ipairs(segments) do
    if type(value) == 'table' and value[segment] then
      value = value[segment]
    else
      return nil
    end
  end
  return value
end

return M
