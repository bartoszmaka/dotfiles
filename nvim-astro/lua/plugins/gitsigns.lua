return {
  'lewis6991/gitsigns.nvim',
  opts = function(_, opts)
    opts.current_line_blame = true
    opts.current_line_blame_formatter = '   <author>, <author_time:%R> • <summary>'
  end
}
