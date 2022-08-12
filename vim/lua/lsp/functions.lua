local set_contains = require('config_helper.set_contains').set_contains

local M = {}

function PeekDefinition()
  local params = vim.lsp.util.make_position_params()
  local definition_callback = function (_, result)
    if result == nil or vim.tbl_isempty(result) then
      print("PeekDefinition: " .. "cannot find the definition.")
      return nil
    end
    --- either Location | LocationLink
    --- https://microsoft.github.io/language-server-protocol/specification#location
    local def_result = result[1]

    -- Peek defintion. Currently, use quickui but a better alternative should be found.
    -- vim.lsp.util.preview_location(result[1])
    local def_uri = def_result.uri or def_result.targetUri
    local def_range = def_result.range or def_result.targetSelectionRange
    vim.fn['quickui#preview#open'](vim.uri_to_fname(def_uri), {
        cursor = def_range.start.line + 1,
        number = 1,   -- show line number
        persist = 0,
      })
  end
  -- Asynchronous request doesn't work very smoothly, so we use synchronous one with timeout;
  -- return vim.lsp.buf_request(0, 'textDocument/definition', params, definition_callback)
  local results, err = vim.lsp.buf_request_sync(0, 'textDocument/definition', params, 5000)
  if results then
    for client_id, result in pairs(results) do
      definition_callback(client_id, result.result)
    end
  else
    print("PeekDefinition: " .. err)
  end
end

vim.cmd [[
  command! -nargs=0 PeekDefinition      :lua PeekDefinition()
  command! -nargs=0 PreviewDefinition   :PeekDefinition
]]

function M.set_default_formatter_for_filetypes(language_server_name, filetypes)
  if not set_contains(filetypes, vim.bo.filetype) then
    return
  end

  local active_servers = {}

  vim.lsp.for_each_buffer_client(0, function(client)
    table.insert(active_servers, client.config.name)
  end)

  if not set_contains(active_servers, language_server_name) then
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

return M
