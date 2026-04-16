-- ctrlp finder — backed by ripgrep for file listing
vim.opt.wildignore:append({ '*/tmp/*', '*.so', '*.swp', '*.zip', '*/node_modules/*' })

vim.g.ctrlp_custom_ignore = 'node_modules\\|DS_Store\\|storage\\|vendor\\|public\\|\\.git'

if vim.fn.executable('rg') == 1 then
  -- `rg --files` respects .gitignore by default; --hidden surfaces dotfiles,
  -- the !.git glob re-excludes the git dir. Near-instant, so caching is off.
  vim.g.ctrlp_user_command = 'rg %s --files --color=never --hidden --glob "!.git/*"'
  vim.g.ctrlp_use_caching = 0
else
  vim.g.ctrlp_use_caching = 0
end
