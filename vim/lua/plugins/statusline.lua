-- Native statusline — replaces lualine.nvim.
-- Same information: mode, branch, diagnostics, file icon + name, fileformat,
-- filetype, progress. Plus per-filetype variants for fugitive, dirvish, and
-- quickfix buffers.
--
-- Components live in `SL` (stored on _G so statusline format strings can
-- call them as `v:lua.SL.mode()` — avoids nested-quote parse errors that
-- occur with the `v:lua.require"mod".fn()` shorthand).

local SL = {}
_G.SL = SL

-- ─── Mode ─────────────────────────────────────────────────────────────────

local mode_map = {
  n       = { 'NORMAL',  'StMode'       },
  i       = { 'INSERT',  'StModeInsert' },
  v       = { 'VISUAL',  'StModeVisual' },
  V       = { 'V-LINE',  'StModeVisual' },
  ['\22'] = { 'V-BLOCK', 'StModeVisual' }, -- Ctrl-V
  c       = { 'COMMAND', 'StModeCmd'    },
  s       = { 'SELECT',  'StModeVisual' },
  S       = { 'S-LINE',  'StModeVisual' },
  R       = { 'REPLACE', 'StModeCmd'    },
  r       = { 'PROMPT',  'StModeCmd'    },
  t       = { 'TERM',    'StModeCmd'    },
}

function SL.mode()
  local m = vim.fn.mode()
  local info = mode_map[m] or { m, 'StMode' }
  return string.format('%%#%s# %s %%*', info[2], info[1])
end

-- ─── Git branch (via fugitive) ─────────────────────────────────────────────

function SL.branch()
  local head = vim.fn.exists('*FugitiveHead') == 1 and vim.fn.FugitiveHead() or ''
  if head == '' then return '' end
  -- match lualine's old "sub(5,8)" treatment — show chars 5..8
  local short = head:sub(5, 8)
  if short == '' then short = head end
  return string.format(' %%#StBranch# %s %%*', short)
end

-- ─── Diagnostics ───────────────────────────────────────────────────────────

function SL.diagnostics()
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

-- ─── File icon ─────────────────────────────────────────────────────────────

local devicons_ok, devicons = pcall(require, 'nvim-web-devicons')

function SL.file_icon()
  if not devicons_ok then return '' end
  local name = vim.fn.expand('%:t')
  local ext  = vim.fn.expand('%:e')
  local icon, hl = devicons.get_icon(name, ext, { default = true })
  if not icon then return '' end
  return string.format('%%#%s#%s %%*', hl or '', icon)
end

-- ─── Statusline format strings ─────────────────────────────────────────────

-- Default — most buffers.
-- Layout: [mode][branch][diagnostics] [icon][filename][mod/ro]  [ff] [ft] [%]
local default = table.concat({
  '%{%v:lua.SL.mode()%}',
  '%{%v:lua.SL.branch()%}',
  '%{%v:lua.SL.diagnostics()%}',
  ' ',
  '%{%v:lua.SL.file_icon()%}',
  '%f',
  '%m%r',                             -- [+] modified, [RO] readonly
  '%=',                               -- right-align pivot
  '%{&ff} ',                          -- fileformat (unix/dos)
  '%y ',                              -- filetype (in brackets)
  '%p%% ',                            -- percentage through file
})

-- Fugitive buffer.
local fugitive = '%{%v:lua.SL.branch()%} %f'

-- Dirvish buffer — mode + branch + dir name.
local dirvish = table.concat({
  '%{%v:lua.SL.mode()%}',
  '%{%v:lua.SL.branch()%}',
  ' %f',
})

-- Quickfix buffer.
local quickfix = ' QuickFix   %=%-15(%l,%c%V%) %P'

-- ─── Highlights ─────────────────────────────────────────────────────────────

local function set_highlights()
  local hl = vim.api.nvim_set_hl
  hl(0, 'StMode',       { fg = '#282c34', bg = '#98c379', bold = true })
  hl(0, 'StModeInsert', { fg = '#282c34', bg = '#61afef', bold = true })
  hl(0, 'StModeVisual', { fg = '#282c34', bg = '#c678dd', bold = true })
  hl(0, 'StModeCmd',    { fg = '#282c34', bg = '#e5c07b', bold = true })
  hl(0, 'StBranch',     { fg = '#ffffff', bg = '#3a3a3a', bold = true })
end
set_highlights()

vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('StatuslineColors', { clear = true }),
  callback = set_highlights,
})

-- ─── Apply ─────────────────────────────────────────────────────────────────

vim.opt.laststatus = 2                             -- always show statusline
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

return SL
