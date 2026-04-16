-- Theme — onedark (darker) + highlight overrides

if vim.fn.has('termguicolors') == 1 then
  vim.opt.termguicolors = true
end

vim.cmd('syntax enable')

vim.g.onedark_config = { style = 'darker' }
vim.cmd.colorscheme('onedark')

-- Highlight-line helpers ---------------------------------------------------

local map = vim.keymap.set
map({ 'n', 'v' }, '<Leader>ha', function()
  vim.fn.matchadd('LineHighlight', '\\%' .. vim.fn.line('.') .. 'l')
end, { silent = true, desc = 'Highlight current line' })

map('n', '<Leader>hc', vim.fn.clearmatches, { silent = true, desc = 'Clear highlighted lines' })

-- Highlight overrides ------------------------------------------------------

local set_hl = vim.api.nvim_set_hl
set_hl(0, 'Search',         { bg = 'none', fg = '#fb5aaa', underline = true, bold = true, italic = true })
set_hl(0, 'IncSearch',      { bg = 'none', fg = '#fb5aaa', underline = true, bold = true, italic = true })
set_hl(0, 'CursorLine',     { bg = '#2E323A' })
set_hl(0, 'NonText',        { fg = 'Gray25', bg = 'none' })
set_hl(0, 'Whitespace',     { fg = 'Gray25', bg = 'none' })
set_hl(0, 'EndOfBuffer',    { fg = 'Gray25', bg = 'none' })
set_hl(0, 'LineHighlight',  { bg = 'Black', fg = 'none' })
