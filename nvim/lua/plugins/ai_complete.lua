return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    -- Was 'InsertEnter': the copilot LSP client needs ~700ms to spawn Node and
    -- initialize, so the first second of typing in a session produced no copilot
    -- items in the blink menu ("copilot didn't start"). Loading when a real file
    -- is opened warms it up while you're still reading the file, and still keeps
    -- it off the startup path for `nvim` with no file.
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        ['*'] = true,
        gitcommit = false,
        gitrebase = false,
        AvanteInput = false,
        ['copilot-chat'] = false,
        ['neo-tree'] = false,
        TelescopePrompt = false,
      },
    },
  },
  {
    'fang2hou/blink-copilot',
    lazy = true,
  },
}
