" theme configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if (has("termguicolors"))
  set termguicolors
endif

syntax enable
set t_Co=256
" colorscheme base16-default-dark

" let g:substrata_italic_comments = 1
" let g:substrata_italic_keywords = 1
" let g:substrata_italic_booleans = 0
" let g:substrata_italic_functions = 1
colorscheme substrata

" let g:tokyonight_style = 'night'
" colorscheme tokyonight

" highlight yank
augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank{ higroup="IncSearch", timeout=700 }
augroup END

" swtich to day colorscheme
function Day()
  :colorscheme base16-gruvbox-light-soft
  :highlight NonText guifg=Gray80
  :highlight WhiteSpace guifg=Gray80
endfunction
command! Day exec Day()

" highlight specific lines
nnoremap <silent> <Leader>ha :call matchadd('LineHighlight', '\%'.line('.').'l')<CR>
vnoremap <silent> <Leader>ha :call matchadd('LineHighlight', '\%'.line('.').'l')<CR>

" clear all the highlighted lines
nnoremap <silent> <Leader>hc :call clearmatches()<CR>

" highlight Normal     guibg=Gray7
" highlight Comment    guifg=Gray45              gui=italic
highlight Search     guibg=none guifg=#fb5aaa gui=underline,bold,italic
highlight IncSearch  guibg=none guifg=#fb5aaa gui=underline,bold,italic

" highlight LineNr     guibg=(synIDattr(hlID("Normal"), "bg")
" highlight VertSplit  guibg=(synIDattr(hlID("Normal"), "bg")
" highlight SignColumn guibg=(synIDattr(hlID("Normal"), "bg") guifg=#282828
" highlight FoldColumn guibg=(synIDattr(hlID("Normal"), "bg")

" vertical and horizontal cursors lines
" highlight Folded       guibg=Gray10 guifg=Gray45
" highlight CursorLine   guibg=Gray10
" highlight ColorColumn  guibg=Gray10
" highlight CursorLineNr guibg=Gray10

" " non text colors
highlight NonText     guifg=Gray25 guibg=none
highlight WhiteSpace  guifg=Gray25 guibg=none
highlight EndOfBuffer guifg=Gray25 guibg=none

" define line highlight color
" highlight LineHighlight ctermbg=darkgray guibg=Gray25

" jsx tags
" highlight jsxOpenPunct   guifg=Grey58
" highlight jsxClosePunct  guifg=Grey58
" highlight jsxCloseString guifg=Grey58

" js
" highlight jsObjectProp guifg=#7cafc2
" highlight link jsObjectKey StorageClass
" highlight link jsDestructuringBraces jsxBraces

" ruby
 " highlight rubyInterpolationDelimiter guifg=#5f8787
