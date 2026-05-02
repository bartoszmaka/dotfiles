return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
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
