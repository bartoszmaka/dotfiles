local null_ls = require("null-ls")

null_ls.setup({
  debug = true,
  sources = {
    -- null_ls.builtins.formatting.codespell,
    -- null_ls.builtins.diagnostics.codespell,

    null_ls.builtins.diagnostics.write_good,

    null_ls.builtins.formatting.stylua,
    -- null_ls.builtins.completion.spell,

    -- null_ls.builtins.formatting.rubocop.with({
    --   extra_args = { "--force-exclusion" }
    -- }),
    -- null_ls.builtins.diagnostics.rubocop.with({
    --   extra_args = { "--force-exclusion" }
    -- }),
    -- null_ls.builtins.formatting.standardrb.with({
    --   condition = function()  end
    -- })
    -- null_ls.builtins.diagnostics.standardrb.with({
    --   condition = function()  end
    -- })

    -- null_ls.builtins.diagnostics.eslint,
    -- null_ls.builtins.formatting.eslint,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.stylelint,
    null_ls.builtins.diagnostics.stylelint,

    null_ls.builtins.formatting.prettier.with({
      prefer_local = "node_modules/.bin",
    }),
  },
})

-- pip3 install codespell
-- npm install -g write-good
