return {
  'lukas-reineke/indent-blankline.nvim',
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    scope = {
      show_start = false,
      show_end = true,
      char = '│'
    },
    indent = {
      char = ' '
    },
    exclude = {
      filetypes = { "fzf", "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
    }

  },
  config = function(_, opts)
    local ibl = require('ibl')
    vim.g.indent_highlight_toggled_visible = 1

    function ToggleIndentMarks()
      if vim.g.indent_highlight_toggled_visible == 1 then
        vim.g.indent_highlight_toggled_visible = 0
        ibl.update({ indent = { char = ' ' } })
      else
        vim.g.indent_highlight_toggled_visible = 1
        ibl.update({ indent = { char = '│' } })
      end
    end

    ibl.setup(opts)

    vim.cmd [[
      nnoremap <leader>uI :IBLToggle<CR>
      nnoremap <leader>ui :lua ToggleIndentMarks()<CR>

      augroup indent_blankline_overrides
      autocmd!
      highlight! IblIndent guifg=#283347
      highlight! IblScope guifg=#455574 gui=nocombine
      augroup END
      ]]
  end,
}
