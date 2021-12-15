" General configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" disable netrw
let loaded_netrwPlugin = 1

set mouse=a
set signcolumn=yes
set relativenumber number
set numberwidth=6
syntax on
filetype plugin indent on
filetype on
filetype indent on
set colorcolumn=80
set ignorecase smartcase
set nowrap
set cursorline
set inccommand=split

" smarter wrap
set breakindent
set breakindentopt=shift:2,min:40,sbr
set showbreak=>>

" split to right, and to bottom
set splitright
set splitbelow

" disable automatic comment leader insertion in command and insert modes
" (:help fo-table)
autocmd FileType * setlocal formatoptions-=r formatoptions-=o

" enable built in matchit
runtime macros/matchit.vim

" rebalance windows on vim resize (useful when opening new tmux panes)
augroup RebalanceWindows
  autocmd!
  autocmd VimResized * :wincmd =
augroup END

" folding
set foldmethod=indent
set foldnestmax=10
set foldlevel=1

" make vim use the global clipboard
set clipboard=unnamedplus

" white spaces
set list
set listchars=tab:→\ ,trail:·,eol:¬,space:·

" fillchars
set fillchars+=diff:╱

" use 0 instead of ^ for beginning of line
nmap 0 ^

" tabs use
set tabstop=2
set expandtab
set shiftwidth=2

" map \q to :q
nnoremap <silent><leader>q :q<CR>

" open url under cursor
nmap <silent>gx :!xdg-open <c-r><c-a><CR>

" go to nvim configurations
nnoremap <silent><leader>cv :e ~/.config/nvim/init.vim<CR>
" reload nvim configurations
nnoremap <silent><leader>rv :source ~/.config/nvim/init.vim<CR>

" disable arrow keys
cnoremap <Up>    <Nop>
cnoremap <Down>  <Nop>
cnoremap <Left>  <Nop>
cnoremap <Right> <Nop>

inoremap <Up>    <Nop>
inoremap <Down>  <Nop>
inoremap <Left>  <Nop>
inoremap <Right> <Nop>

vnoremap <Up>    <Nop>
vnoremap <Down>  <Nop>
vnoremap <Left>  <Nop>
vnoremap <Right> <Nop>

" move between windows (commented because using tmux navigator handles
" movement between tmux and vim as a single unit)
" nnoremap <Up>    <c-w>k
" nnoremap <Down>  <c-w>j
" nnoremap <Left>  <c-w>h
" nnoremap <Right> <c-w>l

" resize vertically and horizontally
nnoremap <silent> <S-Up>    :resize +3<CR>
nnoremap <silent> <S-Down>  :resize -3<CR>
nnoremap <silent> <S-Right> :vertical resize +5<CR>
nnoremap <silent> <S-Left>  :vertical resize -5<CR>

" close buffer without closing window
map <silent> bd :bp<bar>sp<bar>bn<bar>bd<CR>

" make Y yank till the end of the line
nnoremap Y y$

" toggle search highlight
nnoremap <silent> yoh :noh<CR>

" define tag files
set tags=tags;/

" inpsect path option in a more readable format
command! Path :echo join(split(&path, ","), "\n")

" show higlight group for word under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" use ack instead of grep for grepping
set grepprg=ack\ -s\ -H\ --nopager\ --nocolor\ --nogroup\ --column
set grepformat=%f:%l:%c:%m,%f:%l:%m

" grep current word
noremap <Leader>\ :grep -r <cword><CR>
" grep template command
noremap <Leader>x :grep -r "" .<left><left><left>
" replace template :cdo s/word/another//gc | update
noremap <Leader>rep :cdo s/\(<c-r>=expand("<cword>")<cr>\)//gc <bar> update<left><left><left><left><left><left><left><left><left><left><left><left>
