return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    { "nvim-tree/nvim-web-devicons", name = "tree-nvim-web-devicons" }, -- OPTIONAL: for file icons
  },
  init = function() vim.g.barbar_auto_setup = false end,
  commit = "1d6b1386abe97d1d8cba47eb9afa8a9f2d1bbe66",
  opts = {
    animation = true,
    auto_hide = false,
    tabpages = true,
    focus_on_close = 'previous',
    maximum_padding = 1,
    minimum_padding = 1,
    maximum_length = 25,
    minimum_length = 25,
    no_name_title = ' - ',
    highlight_alternate = false,
    highlight_inactive_file_icons = true,
    icons = {
      -- button = '󰖭',
      button = false,
      pinned = {button = '', filename = true},
      separator = {left = '▏', right = '▕'}
    },
    -- sidebar_filetypes = {
    --   ['neo-tree'] = {event = 'BufWipeout'},
    -- }
  },
  config = function(_, opts)
    local nnoremap = require('helper').nnoremap
    vim.g.mapleader = ' '

    require('barbar').setup(opts)

    local close_matchup_window_and_then_close_buffer = function()
      local open_windows = vim.api.nvim_list_wins()
      print(vim.inspect(open_windows))

      for _, value in pairs(open_windows) do
        local config = vim.api.nvim_win_get_config(value)
        local is_matchup_popup_window = config.anchor == "NW" and
        config.external == false and
        config.focusable == false and
        config.zindex == 50 and
        config.relative == "win"

        print(vim.inspect({value, is_matchup_popup_window}))
        if is_matchup_popup_window then
          vim.api.nvim_win_close(value, true)
        end
      end
      vim.cmd [[ BufferClose ]]
    end

    nnoremap('<leader>[', ':BufferPrevious<CR>')
    nnoremap('<leader>]', ':BufferNext<CR>')
    nnoremap('<leader>{', ':BufferMovePrevious<CR>')
    nnoremap('<leader>}', ':BufferMoveNext<CR>')
    nnoremap('<leader>1', ':BufferGoto 1<CR>')
    nnoremap('<leader>2', ':BufferGoto 2<CR>')
    nnoremap('<leader>3', ':BufferGoto 3<CR>')
    nnoremap('<leader>4', ':BufferGoto 4<CR>')
    nnoremap('<leader>5', ':BufferGoto 5<CR>')
    nnoremap('<leader>6', ':BufferGoto 6<CR>')
    nnoremap('<leader>7', ':BufferGoto 7<CR>')
    nnoremap('<leader>8', ':BufferGoto 8<CR>')
    nnoremap('<leader>9', ':BufferLast<CR>')

    nnoremap('<leader>q', ':close<CR>')
    nnoremap('<leader>w', close_matchup_window_and_then_close_buffer)
    nnoremap('<leader>`', ':BufferRestore<CR>')
    nnoremap('<leader><leader>!', ':BufferCloseAllButCurrent<CR>')

    vim.cmd[[
      augroup barbar_overrides
        autocmd!
        highlight! BufferCurrent          guifg=#93a4c3 guibg=#1a212ea gui=bold
        highlight! BufferCurrentMod       guifg=#f2cc81 guibg=#1a212ea gui=NONE
        highlight! BufferCurrentSign      guifg=#f2cc81 guibg=#1a212ea gui=NONE

        highlight! BufferVisible          guifg=#93a4c3 guibg=#1a212ea gui=NONE
        highlight! BufferVisibleMod       guifg=#f2cc81 guibg=#1a212ea gui=NONE
        highlight! BufferVisibleSign      guifg=#1a212e guibg=#1a212ea gui=NONE

        highlight! BufferInactive         guifg=#455574 guibg=#141b24 gui=NONE
        highlight! BufferInactiveMod      guifg=#8f610d guibg=#141b24 gui=NONE
        highlight! BufferInactiveSign     guifg=#141b24 guibg=#141b24 gui=NONE

        highlight! BufferTabpageFill      guifg=#141b24 guibg=#141b24 gui=NONE
      augroup END
    ]]
  end
}
-- 3. Highlights                                              *barbar-highlights*
-- ~
-- Highlight groups are created in this way: `Buffer<STATUS><PART>`.

-- `<STATUS>`   Meaning
-- ---------  --------------------------------------------------
-- `Alternate`  The |alternate-file|.
-- `Current`    The current buffer.
-- `Inactive`   |hidden-buffer|s and |inactive-buffer|s.
-- `Visible`    |active-buffer|s which are not alternate or current.

-- `<PART>`       Meaning
-- ------       -----------------------
-- `ADDED`        Git status added.
-- `CHANGED`      Git status changed.
-- `DELETED`      Git status deleted.
-- `ERROR`        Diagnostic errors.
-- `HINT`         Diagnostic hints.
-- `Icon`         The filetype icon
--              (when `icons.filetype == {custom_colors = true, enabled = true}`).
-- `Index`        The buffer's position in the tabline.
-- `INFO`         Diagnostic info.
-- `Mod`          When the buffer is modified.
-- `Number`       The |bufnr()|.
-- `Sign`         The separator between buffers.
-- `SignRight`    The separator between buffers.
-- `Target`       The letter in buffer-pick mode.
-- `WARN`         Diagnostic warnings.
