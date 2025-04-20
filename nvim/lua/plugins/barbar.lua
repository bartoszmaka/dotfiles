return {
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      { "nvim-tree/nvim-web-devicons", name = "tree-nvim-web-devicons" },
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = function()
      local symbols = require('helper.symbols')
      return {
        tabpages = true,
        focus_on_close = 'previous',
        no_name_title = ' - ',
        highlight_alternate = false,
        highlight_inactive_file_icons = true,
        icons = {
          button = false,
          pinned = { button = symbols.pin, filename = true },
          separator = { left = symbols.bar, right = symbols.bar_right }
        },
      }
    end,
    config = function(_, opts)
      local nnoremap = require('helper').nnoremap
      vim.g.mapleader = ' '

      require('barbar').setup(opts)

      local close_matchup_window_and_then_close_buffer = function()
        local open_windows = vim.api.nvim_list_wins()
        -- print(vim.inspect(open_windows))

        for _, value in pairs(open_windows) do
          local config = vim.api.nvim_win_get_config(value)
          local is_matchup_popup_window = (config.anchor == "NW" or config.anchor == "SW") and
              config.external == false and
              config.focusable == false and
              config.zindex == 50 and
              config.relative == "win"

          -- print(vim.inspect({value, is_matchup_popup_window}))
          if is_matchup_popup_window then
            vim.api.nvim_win_close(value, true)
          end
        end
        vim.cmd [[ silent! BufferClose ]]
      end

      nnoremap('<leader>[', ':BufferPrevious<CR>', { silent = true} )
      nnoremap('<leader>]', ':BufferNext<CR>', { silent = true} )
      nnoremap('<leader>{', ':BufferMovePrevious<CR>', { silent = true} )
      nnoremap('<leader>}', ':BufferMoveNext<CR>', { silent = true} )
      nnoremap('<leader>1', ':BufferGoto 1<CR>', { silent = true} )
      nnoremap('<leader>2', ':BufferGoto 2<CR>', { silent = true} )
      nnoremap('<leader>3', ':BufferGoto 3<CR>', { silent = true} )
      nnoremap('<leader>4', ':BufferGoto 4<CR>', { silent = true} )
      nnoremap('<leader>5', ':BufferGoto 5<CR>', { silent = true} )
      nnoremap('<leader>6', ':BufferGoto 6<CR>', { silent = true} )
      nnoremap('<leader>7', ':BufferGoto 7<CR>', { silent = true} )
      nnoremap('<leader>8', ':BufferGoto 8<CR>', { silent = true} )
      nnoremap('<leader>9', ':BufferLast<CR>', { silent = true} )

      nnoremap('<leader>q', ':close<CR>')
      nnoremap('<leader>w', close_matchup_window_and_then_close_buffer)
      nnoremap('<leader>`', ':BufferRestore<CR>')
      nnoremap('<leader><leader>!', ':BufferCloseAllButCurrent<CR>')

      vim.cmd [[
      augroup barbar_overrides
        autocmd!
        highlight! BufferCurrent          guifg=#93a4c3 guibg=#1a212ea gui=bold
        highlight! BufferCurrentMod       guifg=#f2cc81 guibg=#1a212ea gui=bold
        highlight! BufferCurrentSign      guifg=#93a4c3 guibg=#1a212ea gui=bold

        highlight! BufferVisible          guifg=#93a4c3 guibg=#141b24 gui=bold
        highlight! BufferVisibleMod       guifg=#f2cc81 guibg=#141b24 gui=bold
        highlight! BufferVisibleSign      guifg=#1a212e guibg=#141b24 gui=bold

        highlight! BufferInactive         guifg=#455574 guibg=#141b24 gui=NONE
        highlight! BufferInactiveMod      guifg=#8f610d guibg=#141b24 gui=NONE
        highlight! BufferInactiveSign     guifg=#141b24 guibg=#141b24 gui=NONE

        highlight! BufferTabpageFill      guifg=#141b24 guibg=#141b24 gui=NONE
      augroup END
    ]]
    end
  },
  -- { 'tiagovla/scope.nvim', }
}
