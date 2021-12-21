local setup_servers = require('lsp.setup_servers').setup_servers
local setup_lsp_signature = require('lsp.setup_lsp_signature').setup_lsp_signature
local setup_diagnostics = require('lsp.diagnostics').setup_diagnostics

setup_servers()
setup_diagnostics()
setup_lsp_signature()
