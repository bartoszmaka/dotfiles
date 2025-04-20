return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  -- lazy = false,
  config = function()
    require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end
    })
    -- vim.o.foldcolumn = '1' -- '0' is not bad
    vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = "Open all folds" })
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = "Close all folds" })
    vim.keymap.set('n', "zr", require("ufo").openFoldsExceptKinds, { desc = "Fold less" })
    vim.keymap.set('n', "zm", require("ufo").closeFoldsWith, { desc = "Fold more" })
    vim.keymap.set('n', "zp", require("ufo").peekFoldedLinesUnderCursor, { desc = "Peek fold" })
  end
}
