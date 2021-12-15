" quickfix configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup QuickFixOptions
  autocmd!
  autocmd FileType qf setlocal nolist
  autocmd FileType qf setlocal norelativenumber
  autocmd FileType qf setlocal number
  autocmd FileType qf setlocal nowrap
  autocmd FileType qf 20wincmd_
augroup END
