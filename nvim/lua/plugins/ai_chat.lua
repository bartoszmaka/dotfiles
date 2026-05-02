return {
  {
    'yetone/avante.nvim',
    build = vim.fn.has('win32') ~= 0
      and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
      or 'make',
    version = false,
    cmd = {
      'AvanteAsk',
      'AvanteChat',
      'AvanteToggle',
      'AvanteEdit',
      'AvanteRefresh',
      'AvanteSwitchProvider',
      'AvanteModels',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'stevearc/dressing.nvim',
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.icons',
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = { file_types = { 'markdown', 'Avante' } },
        ft = { 'markdown', 'Avante' },
      },
    },
    opts = {
      provider = 'claude',
      providers = {
        claude = {
          endpoint = 'https://api.anthropic.com',
          model = 'claude-sonnet-4-6',
          auth_type = 'max',
          timeout = 30000,
          extra_request_body = { temperature = 0.2 },
        },
      },
      acp_providers = {
        codex = {
          command = 'npx',
          args = { '-y', '@zed-industries/codex-acp' },
          env = {
            NODE_NO_WARNINGS = '1',
            -- Intentionally NO OPENAI_API_KEY: forces ChatGPT subscription auth
            -- via ~/.codex/auth.json populated by `codex login`.
          },
        },
      },
      windows = {
        position = 'right',
        width = 40,
        sidebar_header = { enabled = true, align = 'center', rounded = false },
      },
    },
  },
}
