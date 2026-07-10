-- fugitive + rhubarb + gitsigns

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

-- gitsigns (replaces vim-gitgutter)
require('gitsigns').setup({
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '|' },
    topdelete    = { text = '‾' },
    changedelete = { text = '│_' },
    untracked    = { text = '┆' },
  },
  signs_staged_enable = true,
  current_line_blame = false,                  -- toggle on demand via <leader>gb
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 300,
  },
  preview_config = { border = 'rounded' },

  on_attach = function(bufnr)
    local gs = require('gitsigns')
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    -- Hunk navigation — preserves gitgutter muscle memory
    map('n', ']h', function() gs.nav_hunk('next') end, 'Next hunk')
    map('n', '[h', function() gs.nav_hunk('prev') end, 'Prev hunk')

    -- Hunk actions
    map('n', '<leader>sh', gs.stage_hunk, 'Stage hunk')
    map('v', '<leader>sh', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, 'Stage hunk')
    map('n', '<leader>uh', gs.reset_hunk, 'Undo hunk (reset to HEAD)')
    map('v', '<leader>uh', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, 'Undo hunk')
    map('n', '<leader>ph', gs.preview_hunk_inline, 'Preview hunk inline')

    -- Git blame virtual text toggle
    map('n', '<leader>gb', gs.toggle_current_line_blame, 'Toggle git blame line')

    -- Hunk text object (bonus)
    map({ 'o', 'x' }, 'ih', gs.select_hunk, 'Inner hunk')
    map({ 'o', 'x' }, 'ah', gs.select_hunk, 'Around hunk')
  end,
})

-- Match gitgutter's sign column colors (green add / red delete / yellow change)
local set_hl = vim.api.nvim_set_hl
set_hl(0, 'GitSignsAdd',          { fg = '#71a95a', bg = 'none' })
set_hl(0, 'GitSignsChange',       { fg = '#E5C07B', bg = 'none' })
set_hl(0, 'GitSignsDelete',       { fg = '#eb7070', bg = 'none' })
set_hl(0, 'GitSignsTopdelete',    { fg = '#eb7070', bg = 'none' })
set_hl(0, 'GitSignsChangedelete', { fg = '#E5C07B', bg = 'none' })
