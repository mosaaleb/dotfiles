local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.erb_lint,
    null_ls.builtins.diagnostics.erb_lint,

    require('none-ls.diagnostics.eslint_d'),
    require('none-ls.formatting.eslint_d'),
    require('none-ls.code_actions.eslint_d'),
  },
})
