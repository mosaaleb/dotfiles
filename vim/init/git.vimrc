" fugitive
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" default to vertical orientation for diffsplit
set diffopt+=vertical

" set foldmethod is manual in git
autocmd FileType git setl foldmethod=manual

command! Glshort :Gclog --max-count=10
command! Glcurrent :Gclog! --first-parent --no-merges master..

" diff highglights
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight DiffAdd       ctermfg=4    guifg=#20303b guibg=#ffffff
highlight DiffText      cterm=bold   ctermfg=2     guibg=#394b70
highlight DiffDelete    ctermfg=12   ctermfg=6     guifg=#37222c guibg=#ffffff
highlight DiffChange    ctermfg=5    guifg=#1f2231 guibg=#ffffff

" gitgutter configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight GitGutterAdd          guifg=#71a95a guibg=none
highlight GitGutterDelete       guifg=#eb7070 guibg=none
highlight GitGutterChange       guifg=#E5C07B guibg=none
highlight GitGutterChangeDelete guifg=#E5C07B guibg=none

nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

nmap <leader>sh <Plug>(GitGutterStageHunk)
nmap <leader>uh <Plug>(GitGutterUndoHunk)
nmap <leader>ph <Plug>(GitGutterPreviewHunk)

let g:gitgutter_preview_win_floating = 0
