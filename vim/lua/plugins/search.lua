-- grep integration — uses ripgrep as grepprg
if vim.fn.executable('rg') == 1 then
  vim.opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
  vim.opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
end

local map = vim.keymap.set

-- grep current word
map('', '<Leader>\\', ':grep -r <cword><CR>')

-- grep template command
map('', '<Leader>x', ':grep -r "" .<Left><Left><Left>')

-- replace template :cdo s/word/another//gc | update
map('', '<Leader>rep',
  ':cdo s/\\(<c-r>=expand("<cword>")<cr>\\)//gc <bar> update<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>')
