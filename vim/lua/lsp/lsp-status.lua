local loaded, lsp_status = pcall(require, 'lsp-status')

local M = {}

M.setup_lsp_status = function()
  if not loaded then
    print('lsp-status not installed. Run PackerInstall / PackerSync')
    return
  end
  lsp_status.config({
    -- Avoid using use emoji-like or full-width characters
    -- because it can often break rendering within tmux and some terminals
    -- See ~/.vim/plugged/lsp-status.nvim/lua/lsp-status.lua
    indicator_hint = '!',
    status_symbol = ' ',

    -- If true, automatically sets b:lsp_current_function
    -- (no longer used in favor of treesitter + nvim-gps)
    current_function = false,
  })
  lsp_status.register_progress()

  -- LspStatus(): status string for airline
  _G.LspStatus = function()
    if #vim.lsp.buf_get_clients() > 0 then
      return lsp_status.status()
    end
    return ''
  end

  -- :LspStatus (command): display lsp status
  vim.cmd [[
    command! -nargs=0 LspStatus   echom v:lua.LspStatus()
  ]]
end

return M
