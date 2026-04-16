-- vim-tmux-navigator
vim.g.tmux_navigator_no_mappings = 1

local map = vim.keymap.set

map('n', '<C-k>', ':TmuxNavigateUp<CR>',    { silent = true })
map('n', '<C-h>', ':TmuxNavigateLeft<CR>',  { silent = true })
map('n', '<C-j>', ':TmuxNavigateDown<CR>',  { silent = true })
map('n', '<C-l>', ':TmuxNavigateRight<CR>', { silent = true })

-- vim-tmux-runner
vim.g.VtrPercentage = 35

map('n', '<leader>rf',   ':VtrSendFile<CR>')
map('n', '<leader>exit', ':VtrSendCtrlD<CR>')
map('n', '<leader>j',    ':VtrOpenRunner<CR>')
map('n', '<leader>k',    ':VtrKillRunner<CR>')
map('n', '<leader>fr',   ':VtrFocusRunner<CR>')
map('n', '<leader>ra',   ':VtrAttachToPane<CR>')
map('n', '<leader>sc',   ':VtrSendCommandToRunner ')
map('n', '<leader>sl',   ':VtrSendLinesToRunner<CR>')
map('v', '<leader>sl',   ':VtrSendLinesToRunner<CR>')
map('n', '<leader>pry',  [[:VtrOpenRunner {'orientation': 'v', 'percentage': 30, 'cmd': 'pry'}<CR>]])
