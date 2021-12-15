" vim tmux navigator configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tmux_navigator_no_mappings = 1

" nnoremap <silent> <Up>    :TmuxNavigateUp<CR>
" nnoremap <silent> <Left>  :TmuxNavigateLeft<CR>
" nnoremap <silent> <Down>  :TmuxNavigateDown<CR>
" nnoremap <silent> <Right> :TmuxNavigateRight<CR>

nnoremap <silent> <C-k>  :TmuxNavigateUp<CR>
nnoremap <silent> <C-h>  :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j>  :TmuxNavigateDown<CR>
nnoremap <silent> <C-l>  :TmuxNavigateRight<CR>

" vim tmux runner
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:VtrPercentage = 35

nnoremap <leader>rf     :VtrSendFile<CR>
nnoremap <leader>exit   :VtrSendCtrlD<CR>
nnoremap <leader>j      :VtrOpenRunner<CR>
nnoremap <leader>k      :VtrKillRunner<CR>
nnoremap <leader>fr     :VtrFocusRunner<CR>
nnoremap <leader>ra     :VtrAttachToPane<CR>
nnoremap <leader>sc     :VtrSendCommandToRunner 
nnoremap <leader>sl     :VtrSendLinesToRunner<CR>
vnoremap <leader>sl     :VtrSendLinesToRunner<CR>
nnoremap <leader>pry    :VtrOpenRunner {'orientation': 'v', 'percentage': 30, 'cmd': 'pry'}<CR>
