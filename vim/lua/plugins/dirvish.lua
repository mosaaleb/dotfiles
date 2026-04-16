vim.g.dirvish_mode = [[:sort ,^\v(.*[\/])|\ze,]]
vim.g.dirvish_relative_paths = 1

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('DirvishOptions', { clear = true }),
  pattern = 'dirvish',
  callback = function()
    vim.opt_local.list = false
  end,
})
