return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "codecompanion" },
    opts = {
      file_types = { "markdown", "codecompanion" },
      bullet = { enabled = false },
      code = {
        enabled = false,
        conceal_delimiters = false,
      },
      quote = { enabled = false },
    },
	},
}
