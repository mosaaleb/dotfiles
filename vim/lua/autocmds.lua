-- Global autocmds (ported from init/general.vimrc + replacement for vim-auto-save)

local au = vim.api.nvim_create_autocmd
local grp = function(name) return vim.api.nvim_create_augroup(name, { clear = true }) end

-- disable automatic comment leader insertion in command and insert modes
au('FileType', {
  group = grp('NoCommentLeader'),
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove({ 'r', 'o' })
  end,
})

-- rebalance windows on vim resize (useful when opening new tmux panes)
au('VimResized', {
  group = grp('RebalanceWindows'),
  pattern = '*',
  command = 'wincmd =',
})

-- highlight yanked text
au('TextYankPost', {
  group = grp('HighlightYank'),
  callback = function()
    vim.hl.on_yank({ higroup = 'IncSearch', timeout = 700 })
  end,
})

-- show line diagnostics automatically in hover window
au({ 'CursorHold', 'CursorHoldI' }, {
  group = grp('DiagnosticHover'),
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

-- diagnostics config (virtual_text off)
vim.diagnostic.config({ virtual_text = false })

-- Auto-save replacement
-- Writes the buffer on InsertLeave / TextChanged, silently.
-- Skipped for typescriptreact (per original config: b:auto_save = 0).
au({ 'InsertLeave', 'TextChanged' }, {
  group = grp('AutoSave'),
  callback = function(args)
    local bo = vim.bo[args.buf]
    if not bo.modifiable then return end
    if bo.buftype ~= '' then return end
    if bo.filetype == 'typescriptreact' then return end
    if vim.api.nvim_buf_get_name(args.buf) == '' then return end
    if not bo.modified then return end
    vim.cmd('silent! update')
  end,
})

-- vim-obsession replacement
-- If you opened nvim with `nvim -S <session>`, auto-save the session on exit
-- so window/buffer layout persists across runs.
au('VimLeavePre', {
  group = grp('AutoSession'),
  callback = function()
    if vim.v.this_session ~= '' then
      vim.cmd('mksession! ' .. vim.fn.fnameescape(vim.v.this_session))
    end
  end,
})
