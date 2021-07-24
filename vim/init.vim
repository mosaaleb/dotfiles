" PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin("~/.vim/plugged")

" rest client
" Plug 'diepm/vim-rest-console'

" dirvish
Plug 'justinmk/vim-dirvish'

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

" " support for node projects
Plug 'moll/vim-node'

" support for ruby projects (rake, lib, ....)
Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-rake'

" fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'

" commentary
Plug 'tpope/vim-commentary'

" colors highlighter
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" gitlens & git & github & gigutter
Plug 'APZelos/blamer.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

" vim bundler (useful for including ctags from installed gems)
Plug 'tpope/vim-bundler'

" " tags management
" Plug 'ludovicchabant/vim-gutentags'

" helpers for unix (Rename, Move, Mkdir, Delete)
Plug 'tpope/vim-eunuch'

" rails
Plug 'tpope/vim-rails'

" endwise
Plug 'tpope/vim-endwise'

" vim surround
Plug 'tpope/vim-surround'

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

" treesitter
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/playground'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CONFIGURATIONS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" General configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" enable treesitter highlight module
lua require('nvim-treesitter.configs').setup { highlight = { enable = true } }
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

" folding
set foldmethod=indent
set foldnestmax=10
set foldlevel=1

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

" swtich to day colorscheme
function Day()
  :colorscheme base16-gruvbox-light-soft
  :highlight NonText guifg=Gray80
  :highlight WhiteSpace guifg=Gray80
endfunction
command! Day exec Day()

" inpsect path option in a more readable format
command! Path :echo join(split(&path, ","), "\n")

" show higlight group for word under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" use ack instead of grep for grepping
set grepprg=ack\ -s\ -H\ --nopager\ --nocolor\ --nogroup\ --column
set grepformat=%f:%l:%c:%m,%f:%l:%m

" dirvish configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let dirvish_mode = ':sort ,^\v(.*[\/])|\ze,'
let g:dirvish_relative_paths = 1
autocmd FileType dirvish setl nolist

" theme configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if (has("termguicolors"))
  set termguicolors
endif

syntax enable
set t_Co=256
colorscheme base16-default-dark

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

" Folding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" augroup AutoSaveFolds
"   autocmd!
"   autocmd BufWinLeave *.* mkview!
"   autocmd BufWinEnter *.* silent! loadview
" augroup END

" Custom highlighting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight Normal     guibg=Gray7

highlight LineNr     guibg=(synIDattr(hlID("Normal"), "bg")
highlight VertSplit  guibg=(synIDattr(hlID("Normal"), "bg")
highlight SignColumn guibg=(synIDattr(hlID("Normal"), "bg") guifg=#282828
highlight FoldColumn guibg=(synIDattr(hlID("Normal"), "bg")

" " vertical and horizontal cursors lines
highlight Folded       guibg=Gray10
highlight CursorLine   guibg=Gray10
highlight ColorColumn  guibg=Gray10
highlight CursorLineNr guibg=Gray10

" non text colors
highlight NonText     guifg=Gray25
highlight WhiteSpace  guifg=Gray25
highlight EndOfBuffer guifg=Gray25

" jsx tags
highlight jsxOpenPunct   guifg=Grey58
highlight jsxClosePunct  guifg=Grey58
highlight jsxCloseString guifg=Grey58

" js
highlight jsObjectProp guifg=#7cafc2
highlight link jsObjectKey StorageClass
highlight link jsDestructuringBraces jsxBraces

" vim-ruby settings
let ruby_operators = 1
let ruby_pseudo_operators = 1
let g:rubycomplete_rails = 1

" statusline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noshowmode
set laststatus=2

function! CurrentWorkingDirectory()
  return fnamemodify(getcwd(), ':t')
endfunction

function! ReadOnly()
  if &readonly || !&modifiable
    return '  '
  else
    return ''
endfunction

function! GitInfo()
  let git = fugitive#head()
  if git != ''
    return ' '.fugitive#head()
  else
    return ''
endfunction

function! IsCurrentWindow()
	return getwinvar(winnr(), 'curr')
endfunction

let g:currentmode={
    \ 'n'      : 'NORMAL',
    \ 'v'      : 'VISUAL',
    \ 'V'      : 'V·LINE',
    \ "\<C-V>" : 'V·Block',
    \ 's'      : 'SELECT',
    \ 'S'      : 'S·LINE',
    \ "\<C-S>" : 'S·BLOCK',
    \ 'i'      : 'INSERT',
    \ 'R'      : 'REPLACE',
    \ 'Rv'     : 'V·REPLACE',
    \ 'c'      : 'COMMAND'
    \}

let g:statusline_bg = "#0c0c0c"
let g:statusline_active_fg = "#6d7d7d"
let g:statusline_inactive_fg = "#404040"
let g:statusline_active_block_bg = "#6d7d7d"
let g:statusline_active_block_fg = "#0c0c0c"
let g:statusline_inactive_block_bg = "#282929"
let g:statusline_inactive_block_fg = "#828282"

execute 'hi User1 guibg=' . g:statusline_bg 'guifg=' . g:statusline_active_fg
execute 'hi User2 guibg=' . g:statusline_active_block_bg   ' guifg=' . g:statusline_active_block_fg ' gui=bold'
execute 'hi User3 guibg=' . g:statusline_inactive_block_bg ' guifg=' . g:statusline_inactive_block_fg

execute 'hi StatusLine   guibg=' . g:statusline_bg ' guifg=' . g:statusline_active_fg
execute 'hi StatusLineNC guibg=' . g:statusline_bg ' guifg=' . g:statusline_inactive_fg

set statusline=
" left side [mode | gitinfo | relative file path | modified flag]
set statusline+=%2*%{IsCurrentWindow()?'\ \ '.g:currentmode[mode()].'\ ':''}%*
set statusline+=%3*%{IsCurrentWindow()?'':'\ \ '.g:currentmode[mode()].'\ '}%*
set statusline+=%3*%{GitInfo()==''?'':'\ \ '.GitInfo().'\ '}%*
set statusline+=%1*\ %f\ %*
set statusline+=%1*\ %m\ %*

" right side [readonly? | line number | percentage | working directory]
set statusline+=%=
set statusline+=%1*\ %{ReadOnly()}\ %*
set statusline+=%1*\ %l/%L\ %*
set statusline+=%1*\ %p%%\ \ %*
set statusline+=%2*%{IsCurrentWindow()?'\ '.CurrentWorkingDirectory().'\ ':''}%*%<
set statusline+=%3*%{IsCurrentWindow()?'':'\ '.CurrentWorkingDirectory().'\ '}%*%<

augroup StatusLineReload
	autocmd!
	autocmd CmdwinLeave,bufLeave,WinLeave * call setwinvar(winnr(), 'curr', 0)
	autocmd CmdwinEnter,bufEnter,WinEnter * call setwinvar(winnr(), 'curr', 1)
augroup END

" autocompletion (nvim-compe) configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set completeopt=menuone,noinsert,noselect

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.ultisnips = v:true

" mappings
inoremap <silent><expr> <C-Space>  compe#complete()
inoremap <silent><expr> <TAB>      pumvisible() ? compe#confirm({ 'keys': '<CR>', 'select': v:true }) : "\<C-g>u\<tab>"
inoremap <silent><expr> <C-j>      pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <silent><expr> <C-k>      pumvisible() ? "\<C-p>" : "\<C-k>"

" nvim-lsp configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
require('lspconfig').solargraph.setup{
  handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = false,
      }
    ),
  }
}

require('lspconfig').tsserver.setup{
  handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = false
      }
    ),
  }
}
EOF

nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap gh <cmd>lua vim.lsp.buf.hover()<CR>
nmap <silent> [g <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nmap <silent> ]g <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" format current buffer
nnoremap <silent> <leader>ff <cmd>lua vim.lsp.buf.formatting()<CR>

" format range
nnoremap <leader>ft <cmd>lua vim.lsp.buf.range_formatting()<CR>
xmap <leader>ft <cmd>lua vim.lsp.buf.range_formatting()<CR>

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

" let g:coc_filetype_map = {
"   \ 'eruby': 'html',
"   \ }

" Use [g and ]g to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use doc to show documentation in preview window.
nnoremap <leader>k :call <SID>show_documentation()<CR>

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

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" ctrlp finder configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ignore patterns
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*

" let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|storage\|log\|vendor\|public\|\.git'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|storage\|vendor\|public\|\.git'

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

" projections to map controllers and request specs
let g:rails_projections = {
      \  "app/controllers/*_controller.rb": {
      \      "test": [
      \        "spec/requests/{}_spec.rb",
      \        "spec/controllers/{}_controller_spec.rb",
      \        "test/controllers/{}_controller_test.rb"
      \      ],
      \      "alternate": [
      \        "spec/requests/{}_spec.rb",
      \        "spec/controllers/{}_controller_spec.rb",
      \        "test/controllers/{}_controller_test.rb"
      \      ],
      \   },
      \   "spec/requests/*_spec.rb": {
      \      "command": "request",
      \      "alternate": "app/controllers/{}_controller.rb",
      \      "template": "require 'rails_helper'\n\n" .
      \        "RSpec.describe '{}' do\nend",
      \   },
      \   "app/javascript/controllers/*_controller.js": {
      \     "command": "stimulus",
      \     "template": "import {open} Controller {close} from 'stimulus';\n\n" .
      \       "export default class extends Controller {\n}",
      \   },
      \   "app/javascript/components/*.js": {
      \     "command": "react",
      \     "template": "import React from 'react';\n\n" .
      \       "const {} = () => (\n" .
      \       "\t<div>This is {}</div>\n);" .
      \       "\n\nexport default {};"
      \   }
      \ }

" test.vim configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let test#strategy = 'vtr'
nnoremap <silent> <leader>l    :TestLast<CR>
nnoremap <silent> <leader>tf   :TestFile<CR>
nnoremap <silent> <leader>s    :TestSuite<CR>
nnoremap <silent> <leader>t    :TestNearest<CR>

let test#ruby#rails#executable = 'docker-compose exec web bundle exec rspec'
let test#ruby#rspec#executable = 'docker-compose exec web bundle exec rspec'

function! ToggleAutoTest()
  if !exists('#AutoTestLast#BufWrite')
    augroup AutoTestLast
      autocmd!
      autocmd BufWrite * if test#exists() |
            \   TestLast |
            \ endif
    augroup END
  else
    augroup AutoTestLast
      autocmd!
    augroup END
  endif
endfunction

command! ToggleAutoTest :call ToggleAutoTest()

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

" vim rest console
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vrc_horizontal_split = 1
let g:vrc_curl_opts = {
      \ '-sS' : '',
      \ '-i': '',
      \}

" seeing is believing configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Assumes you have a Ruby with SiB available in the PATH

function! WithoutChangingCursor(fn)
  let cursor_pos     = getpos('.')
  let wintop_pos     = getpos('w0')
  let old_lazyredraw = &lazyredraw
  let old_scrolloff  = &scrolloff
  set lazyredraw

  call a:fn()

  call setpos('.', wintop_pos)
  call setpos('.', cursor_pos)
  redraw
  let &lazyredraw = old_lazyredraw
  let scrolloff   = old_scrolloff
endfun

function! SibAnnotateAll(scope)
  call WithoutChangingCursor(function('execute', [a:scope . "!seeing_is_believing --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk"]))
endfun

function! SibAnnotateMarked(scope)
  call WithoutChangingCursor(function('execute', [a:scope . "!seeing_is_believing --xmpfilter-style --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk"]))
endfun

function! SibCleanAnnotations(scope)
  call WithoutChangingCursor(function('execute', [a:scope . "!seeing_is_believing --clean"]))
endfun

function! SibToggleMark()
  let pos  = getpos('.')
  let line = getline(".")
  if line =~ '^\s*$'
    let line = '# => '
  elseif line =~ '# =>'
    let line = substitute(line, ' *# =>.*', '', '')
  else
    let line .= '  # => '
  end
  call setline('.', line)
  call setpos('.', pos)
endfun

" Enable seeing-is-believing mappings only for Ruby
augroup seeingIsBelievingSettings
  " clear the settings if they already exist (so we don't run them twice)
  autocmd!
  autocmd FileType ruby nmap <buffer> <Leader>b :call SibAnnotateAll("%")<CR>;
  autocmd FileType ruby nmap <buffer> <Leader>n :call SibAnnotateMarked("%")<CR>;
  autocmd FileType ruby nmap <buffer> <Leader>v :call SibCleanAnnotations("%")<CR>;
  autocmd FileType ruby nmap <buffer> <Enter>   :call SibToggleMark()<CR>;
  autocmd FileType ruby vmap <buffer> <Enter>   :call SibToggleMark()<CR>;

  autocmd FileType ruby vmap <buffer> <Leader>b :call SibAnnotateAll("'<,'>")<CR>;
  autocmd FileType ruby vmap <buffer> <Leader>n :call SibAnnotateMarked("'<,'>")<CR>;
  autocmd FileType ruby vmap <buffer> <Leader>v :call SibCleanAnnotations("'<,'>")<CR>;
augroup END

" END OF FILE
