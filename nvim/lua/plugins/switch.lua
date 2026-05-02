return {
  'andrewradev/switch.vim',
  keys = {
    { '<leader>x', '<cmd>Switch<CR>',        desc = 'Switch: toggle' },
    { '<leader>X', '<cmd>SwitchReverse<CR>', desc = 'Switch: reverse toggle' },
  },
  init = function()
    vim.g.switch_mapping = ''
  end,
  config = function()
    local group = vim.api.nvim_create_augroup('switch_custom_definitions', { clear = true })

    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      pattern = 'ruby',
      callback = function(args)
        vim.b[args.buf].switch_custom_definitions = {
          {
            ['\\([A-Z][a-z]\\+\\).make!\\?(\\(.\\+\\))'] = 'create(:\\L\\1\\e, \\2)',
            ['\\([A-Z][a-z]\\+\\).make!\\?\\W\\?$']     = 'create(:\\L\\1)',
          },
        }
      end,
    })

    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      pattern = 'eruby',
      callback = function(args)
        vim.b[args.buf].switch_custom_definitions = {
          {
            [':\\(\\k\\+\\)\\s\\+=>'] = '\\1:',
            ['\\<\\(\\k\\+\\):']      = ':\\1 =>',
          },
        }
      end,
    })

    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      pattern = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
      callback = function(args)
        vim.b[args.buf].switch_custom_definitions = {
          {
            ['className="\\([a-zA-Z0-9-_]*\\)"'] = 'className={classNames("\\1")}',
          },
        }
      end,
    })
  end,
}
