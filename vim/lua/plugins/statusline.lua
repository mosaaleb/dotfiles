-- Native statusline — replaces lualine.nvim.
-- Same information: mode, branch, diagnostics, filename, filetype, progress,
-- aider background indicator. Plus per-filetype variants for fugitive,
-- dirvish, and quickfix buffers.
--
-- Architecture: `vim.o.statusline` is a format string. Each component lives
-- in the `M` module table and is called via `v:lua.require'plugins.statusline'.<fn>()`.

local M = {}

-- ─── Mode ─────────────────────────────────────────────────────────────────

-- Map vim's one-or-two-char mode() output to a readable label + hl group.
local mode_map = {
  n      = { 'NORMAL',  'StMode'       },
  i      = { 'INSERT',  'StModeInsert' },
  v      = { 'VISUAL',  'StModeVisual' },
  V      = { 'V-LINE',  'StModeVisual' },
  ['\22'] = { 'V-BLOCK', 'StModeVisual' }, -- Ctrl-V
  c      = { 'COMMAND', 'StModeCmd'    },
  s      = { 'SELECT',  'StModeVisual' },
  S      = { 'S-LINE',  'StModeVisual' },
  R      = { 'REPLACE', 'StModeCmd'    },
  r      = { 'PROMPT',  'StModeCmd'    },
  t      = { 'TERM',    'StModeCmd'    },
}

function M.mode()
  local m = vim.fn.mode()
  local info = mode_map[m] or { m, 'StMode' }
  return string.format('%%#%s# %s %%*', info[2], info[1])
end

-- ─── Git branch ────────────────────────────────────────────────────────────

function M.branch()
  local head = vim.fn.exists('*FugitiveHead') == 1 and vim.fn.FugitiveHead() or ''
  if head == '' then return '' end
  -- match lualine's old "sub(5,8)" treatment — show first 4 chars after 4th
  local short = head:sub(5, 8)
  if short == '' then short = head end
  return string.format(' %%#StBranch# %s %%*', short)
end

-- ─── Diagnostics ───────────────────────────────────────────────────────────

function M.diagnostics()
  if #vim.lsp.get_clients({ bufnr = 0 }) == 0 then return '' end
  local counts = vim.diagnostic.count(0)
  local parts = {}
  local severity = vim.diagnostic.severity
  if (counts[severity.ERROR] or 0) > 0 then
    table.insert(parts, '%#DiagnosticError# E:' .. counts[severity.ERROR])
  end
  if (counts[severity.WARN] or 0) > 0 then
    table.insert(parts, '%#DiagnosticWarn# W:' .. counts[severity.WARN])
  end
  if (counts[severity.INFO] or 0) > 0 then
    table.insert(parts, '%#DiagnosticInfo# I:' .. counts[severity.INFO])
  end
  if (counts[severity.HINT] or 0) > 0 then
    table.insert(parts, '%#DiagnosticHint# H:' .. counts[severity.HINT])
  end
  if #parts == 0 then return '' end
  return ' ' .. table.concat(parts, ' ') .. ' %*'
end

-- ─── File icon + name ──────────────────────────────────────────────────────

local devicons_ok, devicons = pcall(require, 'nvim-web-devicons')

function M.file_icon()
  if not devicons_ok then return '' end
  local name = vim.fn.expand('%:t')
  local ext  = vim.fn.expand('%:e')
  local icon, hl = devicons.get_icon(name, ext, { default = true })
  if not icon then return '' end
  return string.format('%%#%s#%s %%*', hl or '', icon)
end

-- ─── Aider background indicator ────────────────────────────────────────────

function M.aider()
  local status = _G.aider_background_status
  if status == 'idle' then
    return '%#StAiderIdle# A %*'
  elseif status == 'working' then
    return '%#StAiderBusy# A %*'
  end
  return ''
end

-- ─── Statusline format strings ─────────────────────────────────────────────

-- Default — most buffers. Matches lualine's layout:
--   [mode] [branch] [diagnostics] [filename (relative)] | [fileformat] [filetype] [progress] [aider]
local default = table.concat({
  '%{%v:lua.require"plugins.statusline".mode()%}',
  '%{%v:lua.require"plugins.statusline".branch()%}',
  '%{%v:lua.require"plugins.statusline".diagnostics()%}',
  ' ',
  '%{%v:lua.require"plugins.statusline".file_icon()%}',
  '%f',
  '%m%r',                           -- [+] modified, [RO] readonly
  '%=',                             -- right-align pivot
  '%{&ff} ',                        -- fileformat (unix/dos)
  '%y ',                            -- filetype (in brackets)
  '%p%% ',                          -- percentage through file
  '%{%v:lua.require"plugins.statusline".aider()%}',
})

-- Fugitive buffer — mimic lualine's fugitive extension.
local fugitive = '%{%v:lua.require"plugins.statusline".branch()%} %f'

-- Dirvish buffer — mode + branch + dir name.
local dirvish = table.concat({
  '%{%v:lua.require"plugins.statusline".mode()%}',
  '%{%v:lua.require"plugins.statusline".branch()%}',
  ' %f',
})

-- Quickfix buffer — title + count.
local quickfix = ' QuickFix   %=%-15(%l,%c%V%) %P'

-- ─── Highlights ─────────────────────────────────────────────────────────────

local function set_highlights()
  local hl = vim.api.nvim_set_hl
  hl(0, 'StMode',       { fg = '#282c34', bg = '#98c379', bold = true })
  hl(0, 'StModeInsert', { fg = '#282c34', bg = '#61afef', bold = true })
  hl(0, 'StModeVisual', { fg = '#282c34', bg = '#c678dd', bold = true })
  hl(0, 'StModeCmd',    { fg = '#282c34', bg = '#e5c07b', bold = true })
  hl(0, 'StBranch',     { fg = '#ffffff', bg = '#3a3a3a', bold = true })
  hl(0, 'StAiderIdle',  { fg = '#8FBCBB' })
  hl(0, 'StAiderBusy',  { fg = '#BF616A' })
end
set_highlights()

-- Re-apply highlights after colorscheme switch.
vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('StatuslineColors', { clear = true }),
  callback = set_highlights,
})

-- ─── Apply ─────────────────────────────────────────────────────────────────

vim.opt.laststatus = 2                           -- always show statusline
vim.opt.statusline = default

-- Per-filetype overrides.
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('StatuslineExtensions', { clear = true }),
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft == 'fugitive' then
      vim.opt_local.statusline = fugitive
    elseif ft == 'dirvish' then
      vim.opt_local.statusline = dirvish
    elseif ft == 'qf' then
      vim.opt_local.statusline = quickfix
    end
  end,
})

return M
