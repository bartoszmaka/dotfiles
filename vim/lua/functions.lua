local M = {}

local efm_priority_document_format

function M.efm_priority_document_format()
  if not efm_priority_document_format then
    local clients = vim.lsp.buf_get_clients(0)

    if #clients > 1 then
      for _, client in pairs(clients) do -- check if multiple clients, and if efm is setup
        if client.name == "efm" then -- if efm then disable others
          for _, c2 in pairs(clients) do
            if c2.name ~= "efm" then c2.resolved_capabilities.document_formatting = false end
          end
          break -- no need to contunue first loop
        end
      end
    end
  end
  -- no need to do above check again
  efm_priority_document_format = true
  -- format the doc
  -- TODO need a check to make sure actually has this func on one of the availble clients
  vim.lsp.buf.formatting()
end

return M
