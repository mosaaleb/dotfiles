-- General options (ported from init/general.vimrc)

-- disable netrw
vim.g.loaded_netrwPlugin = 1

-- point nvim directly at the real python3 (bypass asdf shim to silence
-- nvim's false pyenv-shim warning and skip shim resolution overhead)
vim.g.python3_host_prog = vim.fn.expand('~/.asdf/installs/python/3.10.0/bin/python3')

local opt = vim.opt

opt.mouse = 'a'
opt.signcolumn = 'yes'
opt.relativenumber = true
opt.number = true
opt.numberwidth = 6
opt.colorcolumn = '80'
opt.ignorecase = true
opt.smartcase = true
opt.wrap = false
opt.cursorline = true
opt.inccommand = 'split'

-- smarter wrap
opt.breakindent = true
opt.breakindentopt = 'shift:2,min:40,sbr'
opt.showbreak = '>>'

-- splits
opt.splitright = true
opt.splitbelow = true

-- folding
opt.foldmethod = 'indent'
opt.foldnestmax = 10
opt.foldlevel = 1

-- clipboard
opt.clipboard = 'unnamedplus'

-- whitespace markers
opt.list = true
opt.listchars = { tab = '→ ', trail = '·', eol = '¬', space = '·' }

-- fillchars
opt.fillchars:append({ diff = '╱' })

-- tabs
opt.tabstop = 2
opt.expandtab = true
opt.shiftwidth = 2

-- tags
opt.tags = 'tags;/'

-- diagnostics: no virtual_text, hover updatetime
opt.updatetime = 250

-- completion popup: always show a menu, don't auto-select,
-- show docs popup alongside the menu
opt.completeopt = { 'menu', 'menuone', 'noselect', 'popup' }

-- cmdline completion: popup menu instead of statusline bar (for `:`, `/`, `?`)
opt.wildoptions = 'pum'
opt.wildmode = 'longest:full,full'

-- enable built-in matchit
vim.cmd('runtime macros/matchit.vim')

-- treat mdx files as markdown
vim.filetype.add({
  extension = {
    mdx = 'markdown',
  },
})

-- silence mode echo (lualine shows it)
opt.showmode = false

-- diffopt: default to vertical splits
opt.diffopt:append('vertical')
