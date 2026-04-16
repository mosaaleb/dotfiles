local ok, peek = pcall(require, 'peek')
if ok then
  peek.setup({
    theme = 'light',
    app = 'browser',
  })
  vim.api.nvim_create_user_command('PeekOpen', peek.open, {})
  vim.api.nvim_create_user_command('PeekClose', peek.close, {})
end
