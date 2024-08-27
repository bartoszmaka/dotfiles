return {
  'codota/tabnine-nvim',
  build = "./dl_binaries.sh",
  config = function()
    require('tabnine').setup({
      disable_auto_comment = true,
      accept_keymap = "<M-o>",
      dismiss_keymap = "<C-]>",
      debounce_ms = 400,
      suggestion_color = { gui = "#808080", cterm = 244 },
      exclude_filetypes = { "TelescopePrompt", "NvimTree" },
      log_file_path = nil, -- absolute path to Tabnine log file
    })

    local nnoremap = require("helper").nnoremap
    nnoremap("<C-k><C-a>", require("tabnine.chat").open)
  end
}
