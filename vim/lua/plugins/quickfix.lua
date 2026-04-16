vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('QuickFixOptions', { clear = true }),
  pattern = 'qf',
  callback = function()
    vim.opt_local.list = false
    vim.opt_local.relativenumber = false
    vim.opt_local.number = true
    vim.opt_local.wrap = false
    vim.cmd('20wincmd _')
  end,
})
