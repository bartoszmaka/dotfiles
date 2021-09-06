local set_contains = require('config_helper.set_contains')

local M

M.install_missing_lsp = function ()
  local lspinstall = require "lspinstall"
  local installed_servers = lspinstall.installed_servers()
  local desired_servers = { "ruby", "efm", "yaml", "json", "css", "graphql", "typescript", "html", "lua" }

  for _, lsp_name in ipairs(installed_servers) do
    if not set_contains(desired_servers, lsp_name) then
      lspinstall.install_server(lsp_name)
    end
  end
end

return M
