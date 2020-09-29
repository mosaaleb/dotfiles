" PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin("~/.vim/plugged")

" vim language pack
Plug 'sheerun/vim-polyglot'

" themes
Plug 'joshdick/onedark.vim'
Plug 'chriskempson/base16-vim'
Plug 'edersonferreira/dalton-vim'
Plug 'ayu-theme/ayu-vim'

" nerdtree
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" autosave
Plug '907th/vim-auto-save'

" language server support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" obsession: automatically update sessions
Plug 'tpope/vim-obsession'

" dispatch
Plug 'tpope/vim-dispatch'

" unimpaired (useful for next, previous patterns) EX: :tn => ]t
Plug 'tpope/vim-unimpaired'

" support for ruby projects (rake, lib, ....)
Plug 'tpope/vim-projectionist' | Plug 'tpope/vim-rake'

" fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'

" wakatime
Plug 'wakatime/vim-wakatime'

" commentary
Plug 'tpope/vim-commentary'

" git
Plug 'tpope/vim-fugitive'

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

" ruby select code block
Plug 'nelstrom/vim-textobj-rubyblock'

" repeat vim
Plug 'tpope/vim-repeat'

" text object
Plug 'kana/vim-textobj-user'

" javascript
Plug 'pangloss/vim-javascript'

" use same window navigation mappings in both vim and tmux
Plug 'christoomey/vim-tmux-navigator'

" introduce vim to tmux (second commands from vim to tmux)
Plug 'christoomey/vim-tmux-runner'

" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

" live html, css and javascript
Plug 'turbio/bracey.vim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CONFIGURATIONS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" General configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" split to right, and to bottom
set splitright
set splitbelow

" rebalance windows on vim resize (useful when opening new tmux panes)
autocmd VimResized * :wincmd =

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
nnoremap <leader>q :q<CR>

" go to nvim configurations
nnoremap <leader>cv :vsp ~/.config/nvim/init.vim<CR>
" reload nvim configurations
nnoremap <leader>rv :source ~/.config/nvim/init.vim<CR>

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
nnoremap <silent> <C-Up> :resize +5<CR>
nnoremap <silent> <C-Down> :resize -5<CR>
nnoremap <silent> <C-Right> :vertical resize +5<CR>
nnoremap <silent> <C-Left> :vertical resize -5<CR>

" buffer switching and deleting
map bn :bn<CR>
map bp :bp<CR>
" close buffer without closing window
map <silent> bd :bp<bar>sp<bar>bn<bar>bd<CR>

" " move lines up and down more conventiently
" nnoremap <silent> K :move -2<CR>==
" nnoremap <silent> J :move +1<CR>==
" xnoremap <silent> K :'<,'>move-2<CR>gv=gv
" xnoremap <silent> J :'<,'>move'>+<CR>gv=gv

" make Y yank till the end of the line
nnoremap Y y$

" append alphabet to nrformats (useful in incrementing a letter)
set nrformats+=alpha

" toggle search highlight
noremap <silent> yoh :set invhlsearch<CR>

" define tag files
set tags=tags;/

" Neovim only valid configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" interactive substitute feedback
set inccommand=split

" theme configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if (has("termguicolors"))
  set termguicolors
endif
syntax enable
" set term=screen-256color
set t_Co=256
colorscheme onedark

" nerdtree configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeIgnore      = ['node_modules', '.git']
let g:NERDTreeMinimalUI   = 1 
let g:NERDTreeDirArrows   = 1
let g:NERDTreeQuitOnOpen  = 3
let g:NERDTreeShowHidden  = 1
let g:NERDTreeStatusline  = ''

" auto open nerdtree with no file specified
function! StartUp()
  if 0 == argc()
    NERDTree
  endif
endfunction
au VimEnter * call StartUp() | execute 'normal R'

" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" nerdtree syntax highlighting (plugin)
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeFileExtensionHighlightFullName = 1

" auto refresh root on focus
" autocmd BufWritePost * NERDTreeFocus | execute 'normal R' | wincmd p

" airline configurations
""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme = 'base16_spacemacs'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" COC configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

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
noremap <silent> <leader>ff :call CocAction('format')<CR>

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
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" " Use <TAB> for selections ranges.
" " NOTE: Requires 'textDocument/selectionRange' support from the language server.
" " coc-tsserver, coc-python are the examples of servers that support it.
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" " Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" " Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" " Mappings using CoCList:
" " Show all diagnostics.
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

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

" Rails configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim rails and ruby (rake.vim) alternate (test) file
noremap <silent> <leader>a :A<CR>

" jumping betweem MVC files (model/view/controller) files
nmap <silent> <leader>v :Eview<CR>
nmap <silent> <leader>m :Emodel<CR>
nmap <silent> <leader>h :Ehelper<CR>
nmap <silent> <leader>c :Econtroller<CR>

" restart server
nmap <leader>rs :Rails restart<CR>

" rspec syntax highlight outside of rails projects
autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject its shared_examples_for shared_context let
highlight def link rubyRspec Function

" test.vim configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let test#strategy = 'vtr'
nmap <silent> <leader>l    :TestLast<CR>
nmap <silent> <leader>tf   :TestFile<CR>
nmap <silent> <leader>s    :TestSuite<CR>
nmap <silent> <leader>t    :TestNearest<CR>

" Ultisnips
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" disable ultisnips mappings (because it conflicts with coc default mappings)
let g:UltiSnipsExpandTrigger = "<nop>"

" vim gitgutter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight DiffAdd guifg=#71a95a guibg=none
highlight DiffDelete guifg=#eb7070 guibg=none

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

" hot reload html css
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" reload css, js after leaving insert mode


" END OF FILE
