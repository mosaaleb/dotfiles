" fugitive
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" default to vertical orientation for diffsplit
set diffopt+=vertical

" set foldmethod is manual in git
autocmd FileType git setl foldmethod=manual

command! Glshort :Gclog --max-count=10
command! Glcurrent :Gclog! --first-parent --no-merges master..

" gitgutter configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_preview_win_floating = 0

let g:gitgutter_sign_added                   = '│'
let g:gitgutter_sign_removed                 = '_'
let g:gitgutter_sign_modified                = '│'
let g:gitgutter_sign_modified_removed        = '│_'
let g:gitgutter_sign_removed_first_line      = '‾'
let g:gitgutter_sign_removed_above_and_below = '_¯'

highlight GitGutterAdd          guifg=#71a95a guibg=none
highlight GitGutterDelete       guifg=#eb7070 guibg=none
highlight GitGutterChange       guifg=#E5C07B guibg=none
highlight GitGutterChangeDelete guifg=#E5C07B guibg=none

nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

nmap <leader>sh <Plug>(GitGutterStageHunk)
nmap <leader>uh <Plug>(GitGutterUndoHunk)
nmap <leader>ph <Plug>(GitGutterPreviewHunk)
