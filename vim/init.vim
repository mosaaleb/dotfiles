" PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin("~/.vim/plugged")

" dirvish & dirvish git
Plug 'justinmk/vim-dirvish'
Plug 'kristijanhusak/vim-dirvish-git'

" bufferline
Plug 'ap/vim-buftabline'

" vim language pack
Plug 'sheerun/vim-polyglot'

" color scheme
Plug 'chriskempson/base16-vim'

" autosave
Plug '907th/vim-auto-save'

" language server support
Plug 'neoclide/coc.nvim', {'branch': 'release', 'on': []}

" snippets
Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'

" obsession: automatically update sessions
Plug 'tpope/vim-obsession'

" dispatch
Plug 'tpope/vim-dispatch'

" unimpaired (useful for next, previous patterns) EX: :tn => ]t
Plug 'tpope/vim-unimpaired'

" support for ruby projects (rake, lib, ....)
Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-rake'

" fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'

" wakatime
Plug 'wakatime/vim-wakatime'

" commentary
Plug 'tpope/vim-commentary'

" gitlens & git & github & gigutter
Plug 'APZelos/blamer.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

" vim bundler (useful for including ctags from installed gems)
Plug 'tpope/vim-bundler'

" helpers for unix (Rename, Move, Mkdir, Delete)
Plug 'tpope/vim-eunuch'

" rails
Plug 'tpope/vim-rails'

" endwise
Plug 'tpope/vim-endwise'

" rvm vim
Plug 'tpope/vim-rvm'

" vim surround
Plug 'tpope/vim-surround'

" autoclose tag
Plug 'alvan/vim-closetag'

" Autogenerate pairs for '{(['
Plug 'jiangmiao/auto-pairs'

" vim ruby
Plug 'vim-ruby/vim-ruby'

" vim test runner
Plug 'janko/vim-test'

" ruby ri documentation
Plug 'danchoi/ri.vim'

" repeat vim
Plug 'tpope/vim-repeat'

" text object
Plug 'kana/vim-textobj-user'
  Plug 'nelstrom/vim-textobj-rubyblock'

" javascript
Plug 'pangloss/vim-javascript'

" use same window navigation mappings in both vim and tmux
Plug 'christoomey/vim-tmux-navigator'

" introduce vim to tmux (second commands from vim to tmux)
Plug 'christoomey/vim-tmux-runner'

" live html, css and javascript
Plug 'turbio/bracey.vim'

" devicons
Plug 'ryanoasis/vim-devicons'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CONFIGURATIONS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" General configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" disable netrw
let loaded_netrwPlugin = 1

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

" make vim use the global clipboard
set clipboard=unnamedplus

" white spaces
set list
set listchars=tab:→\ ,trail:·,eol:¬,space:·

" use 0 instead of ^ for beginning of line
nmap 0 ^

" tabs use
set tabstop=2
set expandtab
set shiftwidth=2

" map \q to :q
nnoremap <silent><leader>q :q<CR>

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

" move between windows (commented because using tmux navigator default mapping)
" nnoremap <Up>    <c-w>k
" nnoremap <Down>  <c-w>j
" nnoremap <Left>  <c-w>h
" nnoremap <Right> <c-w>l

" resize vertically and horizontally
nnoremap <silent> <C-Up>    :resize +5<CR>
nnoremap <silent> <C-Down>  :resize -5<CR>
nnoremap <silent> <C-Right> :vertical resize +5<CR>
nnoremap <silent> <C-Left>  :vertical resize -5<CR>

" buffer switching and deleting
map bn :bn<CR>
map bp :bp<CR>
" close buffer without closing window
map <silent> bd :bp<bar>sp<bar>bn<bar>bd<CR>

" make Y yank till the end of the line
nnoremap Y y$

" toggle search highlight
nnoremap <silent> yoh :noh<CR>

" define tag files
set tags=tags;/

" load coc.nvim after vim started
augroup LoadCocNvim
  autocmd!
  autocmd VimEnter * call plug#load('coc.nvim')
                     \| autocmd! LoadCocNvim
augroup END

" dirvish configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let dirvish_mode = ':sort ,^.*/,'
autocmd FileType dirvish setl nolist
" call dirvish#add_icon_fn({p -> WebDevIconsGetFileTypeSymbol(p)})

" dirvish git
let g:dirvish_git_show_ignored = 1

" theme configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if (has("termguicolors"))
  set termguicolors
endif

syntax enable
set t_Co=256
colorscheme base16-default-dark

" Folding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup remember_folds
  autocmd!
  au BufWinLeave ?* mkview 1
  au BufWinEnter ?* silent! loadview 1
augroup END

" Custom highlighting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" same as (Normal) colorscheme bg color (synIDattr(hlID("Normal"), "bg")
highlight Normal     guibg=Black
highlight LineNr     guibg=Black
highlight VertSplit  guibg=Black guifg=Grey14
highlight SignColumn guibg=Black

" vertical and horizontal cursors lines
highlight CursorLine   guibg=#0c0c0c
highlight ColorColumn  guibg=#0c0c0c
highlight CursorLineNr guibg=#0c0c0c

" non text colors
highlight NonText     guifg=Grey14
highlight WhiteSpace  guifg=Grey14
highlight EndOfBuffer guifg=Gray14

" vim-ruby settings
let ruby_operators = 1
let ruby_pseudo_operators = 1

" buftabline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight BufTabLineFill    guibg=#0c0c0c
highlight BufTabLineActive  guibg=#3c3c3c guifg=#eca55c
highlight BufTabLineHidden  guibg=#202020 guifg=#909090
highlight BufTabLineCurrent guibg=#3c3c3c guifg=#eca55c

" statusline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noshowmode
set laststatus=2

function! CurrentFile()
  return expand(fnamemodify(expand('%h'), ':t'))
endfunction

function! CurrentWorkingDirectory()
  return fnamemodify(getcwd(), ':t')
endfunction

function! ReadOnly()
  if &readonly || !&modifiable
    return '  '
  else
    return ''
endfunction

function! GitBranchIcon()
  let git = fugitive#head()
  if git != ''
    return ''
  else
    return ''
endfunction

function! GitInfo()
  let git = fugitive#head()
  if git != ''
    return fugitive#head()
  else
    return ''
endfunction

hi User1   guibg=#0c0c0c guifg=#eca55c
hi User2   guibg=#0c0c0c guifg=#eca55c gui=bold
hi User3   guibg=#0c0c0c guifg=#ff0000 gui=bold

hi StatusLine    guibg=#0c0c0c
hi StatusLineNC  guibg=#0c0c0c
set statusline=

let g:currentmode={
    \ 'n'      : 'NORMAL ',
    \ 'v'      : 'VISUAL ',
    \ 'V'      : 'V·LINE ',
    \ "\<C-V>" : 'V·Block ',
    \ 's'      : 'SELECT ',
    \ 'S'      : 'S·LINE ',
    \ "\<C-S>" : 'S·BLOCK ',
    \ 'i'      : 'INSERT ',
    \ 'R'      : 'REPLACE ',
    \ 'Rv'     : 'V·REPLACE ',
    \ 'c'      : 'COMMAND '
    \}

" left side [mode | gitinfo | relative file path]
set statusline+=%2*%{g:currentmode[mode()]}

set statusline+=%1*\ %5{GitBranchIcon()}%*
set statusline+=%1*\ %{GitInfo()}\ %*

set statusline+=%1*\ %5{WebDevIconsGetFileTypeSymbol()}%*
set statusline+=%1*\ %f%*

" right side [lines number | percentage | working directory]
set statusline+=%=
set statusline+=%3*%-5{ReadOnly()}%*

set statusline+=%1*\ 🗋\ %*
set statusline+=%1*%-5L%*

set statusline+=%1*\ ％%*
set statusline+=%1*%-5p%*

set statusline+=%1*\ 🖿%*
set statusline+=%2*\ %{CurrentWorkingDirectory()}%*%<

" COC configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c

" Completion
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" use c-j and c-k to navigate completion list
inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" use tab to confirm completion
if exists('*complete_info')
  inoremap <expr> <tab> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<tab>"
else
  imap <expr> <tab> pumvisible() ? "\<C-y>" : "\<C-g>u\<tab>"
endif

" use tab to automatically select the first item in list
inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<tab>"

" Use [g and ]g to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use doc to show documentation in preview window.
nnoremap <leader>doc :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" format file
nnoremap <silent> <leader>ff :call CocAction('format')<CR>

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
" nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)


" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" " Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" " Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" ctrlp finder configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ignore patterns
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn))$',
      \ 'file': '\v\.(exe|so|dll)$',
      \ }

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|storage\|public\|log\|vendor\|public'
" turn off ctrlp caching
let g:ctrlp_use_caching = 0

" Autosave configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:auto_save = 1
let g:auto_save_silent = 1

" Ruby & Ruby on Rails configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim rails and ruby (rake.vim) alternate (test) file
nnoremap <silent> <leader>a :A<CR>

" jumping betweem MVC files (model/view/controller) files
nnoremap <silent> <leader>v :Eview<CR>
nnoremap <silent> <leader>m :Emodel<CR>
nnoremap <silent> <leader>h :Ehelper<CR>
nnoremap <silent> <leader>c :Econtroller<CR>

" restart server
noremap <leader>rs :Rails restart<CR>

" rspec syntax highlight outside of rails projects
augroup RSpecHighlight
  autocmd!

  autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject its shared_examples_for shared_context let
  highlight def link rubyRspec Function
augroup END

" test.vim configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let test#strategy = 'vtr'
nnoremap <silent> <leader>l    :TestLast<CR>
nnoremap <silent> <leader>tf   :TestFile<CR>
nnoremap <silent> <leader>s    :TestSuite<CR>
nnoremap <silent> <leader>t    :TestNearest<CR>

" Ultisnips
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" disable ultisnips mappings (conflicts with coc default mappings)
let g:UltiSnipsExpandTrigger = "<nop>"

" vim tmux navigator configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <Up>    :TmuxNavigateUp<CR>
nnoremap <silent> <Left>  :TmuxNavigateLeft<CR>
nnoremap <silent> <Down>  :TmuxNavigateDown<CR>
nnoremap <silent> <Right> :TmuxNavigateRight<CR>

" vim tmux runner
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:VtrPercentage = 35

nnoremap <leader>rf     :VtrSendFile<CR>
nnoremap <leader>exit   :VtrSendCtrlD<CR>
nnoremap <leader>j      :VtrOpenRunner<CR>
nnoremap <leader>k      :VtrKillRunner<CR>
nnoremap <leader>fr     :VtrFocusRunner<CR>
nnoremap <leader>ar     :VtrAttachToPane<CR>
nnoremap <leader>sc     :VtrSendCommandToRunner 
nnoremap <leader>sl     :VtrSendLinesToRunner<CR>
vnoremap <leader>sl     :VtrSendLinesToRunner<CR>
nnoremap <leader>pry    :VtrOpenRunner {'orientation': 'v', 'percentage': 30, 'cmd': 'pry'}<CR>

let g:vtr_filetype_runner_overrides = {
        \ 'php': 'php {file}'
        \ }

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

" END OF FILE
