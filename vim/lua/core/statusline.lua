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

-- Single-letter mode indicators — all render with the StMode pill.
local mode_map = {
  n       = 'N',
  i       = 'I',
  v       = 'V',
  V       = 'V',
  ['\22'] = 'V',  -- Ctrl-V / visual-block
  c       = 'C',
  s       = 'S',
  S       = 'S',
  R       = 'R',
  r       = 'P',
  t       = 'T',
}

function SL.mode()
  local label = mode_map[vim.fn.mode()] or '?'
  return string.format('%%#StMode# %s %%*', label)
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
-- Layout: [mode][branch][diagnostics] [icon][filename][mod/ro]  [filetype][%]
local default = table.concat({
  '%{%v:lua.SL.mode()%}',               -- deep-shade pill (N/I/V/…)
  '%{%v:lua.SL.branch()%}',             -- light-shade pill
  '%{%v:lua.SL.diagnostics()%}',
  ' ',
  '%{%v:lua.SL.file_icon()%}',
  '%f',
  '%m%r',                               -- [+] modified, [RO] readonly
  '%=',                                 -- right-align pivot
  '%#StBranch# %{&filetype} %*',        -- filetype (matches branch pill)
  '%#StMode# %p%% %*',                  -- percentage (matches mode pill)
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
--
-- Everything is derived from the active colorscheme's palette:
--   1. Pluck fg/bg from existing groups — never hardcode hex.
--   2. Use `shade(color, amount)` to shift lightness for a hierarchical look.
--      Negative darkens (toward black), positive lightens (toward white).
--      Shallow shifts (0.1 – 0.3) feel subtle; beyond ±0.4 looks heavy-handed.
--
-- Monochromatic shade ladder — all derived from Normal.bg, all darker than
-- the editor. Distinction comes from shade depth, not accent color.
--   editor bg      = Normal.bg              — reference
--   branch pill    = shade(Normal.bg, -.10) — lightest of the darker shades
--   statusline bg  = shade(Normal.bg, -.20) — middle
--   mode pill      = shade(Normal.bg, -.35) — deepest
-- Mode + percentage share StMode (deep). Branch + filetype share StBranch (light).
--
-- `:hi clear` fires during colorscheme load, so we re-apply on ColorScheme.

local function fg_of(group)
  return vim.api.nvim_get_hl(0, { name = group, link = false }).fg
end

local function bg_of(group)
  return vim.api.nvim_get_hl(0, { name = group, link = false }).bg
end

-- Blend a 24-bit color toward black (negative) or white (positive).
-- `amount` in [-1, 1]; |amount| ~0.1–0.3 is a natural range.
local function shade(color, amount)
  if not color then return nil end
  local r = math.floor(color / 65536) % 256
  local g = math.floor(color / 256) % 256
  local b = color % 256
  local target = amount > 0 and 255 or 0
  local a = math.abs(amount)
  r = math.floor(r + (target - r) * a + 0.5)
  g = math.floor(g + (target - g) * a + 0.5)
  b = math.floor(b + (target - b) * a + 0.5)
  return r * 65536 + g * 256 + b
end

local function set_highlights()
  local normal_bg = bg_of('Normal')
  local normal_fg = fg_of('Normal')

  -- Three shades from Normal.bg, all darker. Tweak these three numbers to
  -- tighten or widen the contrast between pills and statusline body.
  local light = shade(normal_bg, -0.10)   -- branch / filetype
  local mid   = shade(normal_bg, -0.20)   -- statusline body
  local deep  = shade(normal_bg, -0.35)   -- mode / percentage

  vim.api.nvim_set_hl(0, 'StatusLine',   { fg = normal_fg,        bg = mid })
  vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = fg_of('Comment'), bg = mid })

  -- Deep-shade pill (mode + percentage).
  vim.api.nvim_set_hl(0, 'StMode',
    { fg = normal_fg, bg = deep, bold = true })

  -- Light-shade pill (branch + filetype). Accent fg from Keyword for a touch
  -- of color contrast against the otherwise-monochromatic shade ladder.
  vim.api.nvim_set_hl(0, 'StBranch',
    { fg = fg_of('Keyword'), bg = light, bold = true })
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
