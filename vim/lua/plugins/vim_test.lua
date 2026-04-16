-- vim-test
vim.g['test#strategy'] = 'vtr'

local map = vim.keymap.set
map('n', '<leader>l',  ':TestLast<CR>',    { silent = true })
map('n', '<leader>tf', ':TestFile<CR>',    { silent = true })
map('n', '<leader>s',  ':TestSuite<CR>',   { silent = true })
map('n', '<leader>t',  ':TestNearest<CR>', { silent = true })

vim.g['test#ruby#rspec#options'] = {
  nearest = '--format documentation',
  file    = '--format documentation',
  last    = '--format documentation',
  suite   = '--format documentation',
}

-- ToggleAutoTest: re-run TestLast on every BufWrite when enabled
vim.api.nvim_create_user_command('ToggleAutoTest', function()
  local group_name = 'AutoTestLast'
  local ok = pcall(vim.api.nvim_get_autocmds, { group = group_name, event = 'BufWritePost' })
  local existing = ok and #vim.api.nvim_get_autocmds({ group = group_name, event = 'BufWritePost' }) > 0

  if not existing then
    vim.api.nvim_create_autocmd('BufWritePost', {
      group = vim.api.nvim_create_augroup(group_name, { clear = true }),
      callback = function()
        if vim.fn['test#exists']() == 1 then
          vim.cmd('TestLast')
        end
      end,
    })
    vim.notify('AutoTest: ON')
  else
    vim.api.nvim_create_augroup(group_name, { clear = true })
    vim.notify('AutoTest: OFF')
  end
end, {})
