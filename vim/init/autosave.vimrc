" Autosave configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:auto_save = 1

augroup ft_typescript
  au!
  au FileType typescriptreact let b:auto_save = 0
augroup END

let g:auto_save_silent = 1
