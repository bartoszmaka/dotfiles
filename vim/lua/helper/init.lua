local M = {}

M.colors = require('helper.colors')
M.symbols = require('helper.symbols')
M.statusline = require('helper.statusline_segments')
M.lualine = require('helper.lualine')

function M.map(from, to, mode, opts)
  local options = { noremap = true }
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

function M.set_contains(set, val)
  for key, value in pairs(set) do
    if value == val then return true end
  end
  return false
end

function M.safe_require(package_name)
  local loaded, package = pcall(require, package_name)
  if not loaded then print("Error loading " .. package_name) end
  return package
end

function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

function M.on_very_lazy(fn)
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      fn()
    end,
  })
end

function M.lazy_notify()
  local notifs = {}
  local function temp(...)
    table.insert(notifs, vim.F.pack_len(...))
  end

  local orig = vim.notify
  vim.notify = temp

  local timer = vim.loop.new_timer()
  local check = vim.loop.new_check()

  local replay = function()
    timer:stop()
    check:stop()
    if vim.notify == temp then
      vim.notify = orig -- put back the original notify if needed
    end
    vim.schedule(function()
      ---@diagnostic disable-next-line: no-unknown
      for _, notif in ipairs(notifs) do
        vim.notify(vim.F.unpack_len(notif))
      end
    end)
  end

  -- wait till vim.notify has been replaced
  check:start(function()
    if vim.notify ~= temp then
      replay()
    end
  end)
  -- or if it took more than 500ms, then something went wrong
  timer:start(500, 0, replay)
end

function M.fg(name)
  ---@type {foreground?:number}?
  local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name }) or vim.api.nvim_get_hl_by_name(name, true)
  local fg = hl and hl.fg or hl.foreground
  return fg and { fg = string.format("#%06x", fg) }
end

function M.set_default_formatter_for_filetypes(language_server_name, filetypes)
  if not M.set_contains(filetypes, vim.bo.filetype) then
    return
  end

  local active_servers = {}

  vim.lsp.for_each_buffer_client(0, function(client)
    table.insert(active_servers, client.config.name)
  end)

  if not M.set_contains(active_servers, language_server_name) then
    return
  end

  vim.lsp.for_each_buffer_client(0, function(client)
    if client.name ~= language_server_name then
      if (vim.fn.has('nvim-0.8') == 1) then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      else
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
      end
    end
  end)
end

-- function get(t, ...)
--    local result = t
--    for i = 1, select(#, ...) do
--       local key = select(i, ...)
--       local nv  = result[key]
--       if nv ~= nil then
--           result = nv
--       else
--           return
--       end
--    end
--    return result
-- end

M.keys = function(obect)
  local result = {}
  for key, _ in pairs(obect) do
    table.insert(result, key)
  end
  return result
end

M.get = function(obect, path)
  local value = obect
  local segments = {}

  -- Split the path into segments
  for segment in string.gmatch(path, "[^%.]+") do
    table.insert(segments, segment)
  end

  -- Traverse the obect based on the path segments
  for _, segment in ipairs(segments) do
    if type(value) == "table" and value[segment] then
      value = value[segment]
    else
      return nil       -- Return nil if the segment doesn't exist
    end
  end

  return value
end

return M
