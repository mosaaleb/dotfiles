-- Global keymaps (ported from init/general.vimrc)

local map = vim.keymap.set

-- use 0 instead of ^ for beginning of line
map('n', '0', '^')

-- :q shortcut
map('n', '<leader>q', ':q<CR>', { silent = true })

-- open url under cursor
map('n', 'gx', ':!xdg-open <c-r><c-a><CR>', { silent = true })

-- go to / reload nvim config
map('n', '<leader>cv', ':e ~/.config/nvim/init.lua<CR>', { silent = true })
map('n', '<leader>rv', ':source ~/.config/nvim/init.lua<CR>', { silent = true })

-- disable arrow keys
for _, mode in ipairs({ 'c', 'i', 'v' }) do
  map(mode, '<Up>', '<Nop>')
  map(mode, '<Down>', '<Nop>')
  map(mode, '<Left>', '<Nop>')
  map(mode, '<Right>', '<Nop>')
end

-- resize vertically and horizontally
map('n', '<S-Up>',    ':resize +3<CR>',          { silent = true })
map('n', '<S-Down>',  ':resize -3<CR>',          { silent = true })
map('n', '<S-Right>', ':vertical resize +5<CR>', { silent = true })
map('n', '<S-Left>',  ':vertical resize -5<CR>', { silent = true })

-- close buffer without closing window
map('', 'bd', ':bp<bar>sp<bar>bn<bar>bd<CR>', { silent = true })

-- Y yanks to end of line (instead of whole line)
map('n', 'Y', 'y$')

-- toggle search highlight
map('n', 'yoh', ':noh<CR>', { silent = true })

-- inspect path option
vim.api.nvim_create_user_command('Path', function()
  print(table.concat(vim.split(vim.o.path, ','), '\n'))
end, {})

-- show highlight group for word under cursor
map('', '<F10>', function()
  local line, col = vim.fn.line('.'), vim.fn.col('.')
  local function syn_name(trans_id, mode)
    local id = vim.fn.synID(line, col, mode)
    if trans_id then id = vim.fn.synIDtrans(id) end
    return vim.fn.synIDattr(id, 'name')
  end
  print(string.format('hi<%s> trans<%s> lo<%s>',
    syn_name(false, 1), syn_name(false, 0), syn_name(true, 1)))
end)

-- Format json (needs jq)
vim.api.nvim_create_user_command('JsonFormat', '%!jq .', {})
