-- fugitive + rhubarb + gitgutter

-- manual foldmethod in git buffers
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('GitFoldmethod', { clear = true }),
  pattern = 'git',
  callback = function()
    vim.opt_local.foldmethod = 'manual'
  end,
})

vim.api.nvim_create_user_command('Glshort',   'Gclog --max-count=10', {})
vim.api.nvim_create_user_command('Glcurrent', 'Gclog! --first-parent --no-merges main..', {})

-- gitgutter
vim.g.gitgutter_preview_win_floating = 0
vim.g.gitgutter_sign_added                   = '│'
vim.g.gitgutter_sign_removed                 = '_'
vim.g.gitgutter_sign_modified                = '│'
vim.g.gitgutter_sign_modified_removed        = '│_'
vim.g.gitgutter_sign_removed_first_line      = '‾'
vim.g.gitgutter_sign_removed_above_and_below = '_¯'

local set_hl = vim.api.nvim_set_hl
set_hl(0, 'GitGutterAdd',          { fg = '#71a95a', bg = 'none' })
set_hl(0, 'GitGutterDelete',       { fg = '#eb7070', bg = 'none' })
set_hl(0, 'GitGutterChange',       { fg = '#E5C07B', bg = 'none' })
set_hl(0, 'GitGutterChangeDelete', { fg = '#E5C07B', bg = 'none' })

local map = vim.keymap.set
map('n', ']h',         '<Plug>(GitGutterNextHunk)')
map('n', '[h',         '<Plug>(GitGutterPrevHunk)')
map('n', '<leader>sh', '<Plug>(GitGutterStageHunk)')
map('n', '<leader>uh', '<Plug>(GitGutterUndoHunk)')
map('n', '<leader>ph', '<Plug>(GitGutterPreviewHunk)')
