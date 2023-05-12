" PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin("~/.vim/plugged")

" rest client
Plug 'diepm/vim-rest-console'

" dirvish
Plug 'justinmk/vim-dirvish'

" vim language pack
Plug 'sheerun/vim-polyglot'

" colorscheme
" Plug 'chriskempson/base16-vim'
" Plug 'olimorris/onedarkpro.nvim'
Plug 'navarasu/onedark.nvim'

" quickfix
Plug 'kevinhwang91/nvim-bqf'

" autosave
Plug '907th/vim-auto-save'

" language server common configuration
" Plug 'neovim/nvim-lspconfig'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" auto-completion
" Plug 'hrsh7th/nvim-compe'

" snippets
Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'

" obsession: automatically update sessions
Plug 'tpope/vim-obsession'

" dispatch
Plug 'tpope/vim-dispatch'

" unimpaired (useful for next, previous patterns) EX: :tn => ]t, :bp => [b, etc
Plug 'tpope/vim-unimpaired'

" split joins
Plug 'AndrewRadev/splitjoin.vim'

" sql formatter
Plug 'vim-scripts/SQLUtilities'
 Plug 'vim-scripts/Align'

" support for ruby projects (rake, lib, ....)
Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-rake'

" fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'

" commentary
Plug 'tpope/vim-commentary'

" git & github browsing
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" gitgutter
Plug 'airblade/vim-gitgutter'

" lualine
Plug 'nvim-lualine/lualine.nvim'

" vim bundler (useful for including ctags from installed gems)
Plug 'tpope/vim-bundler'

" tags management (auto update tags)
Plug 'ludovicchabant/vim-gutentags'

" helpers for unix (Rename, Move, Mkdir, Delete)
Plug 'tpope/vim-eunuch'

" rails
Plug 'tpope/vim-rails'

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

" javascript & react
Plug 'neoclide/vim-jsx-improve'

" use same window navigation mappings in both vim and tmux
Plug 'christoomey/vim-tmux-navigator'

" introduce vim to tmux (send commands from vim to tmux)
Plug 'christoomey/vim-tmux-runner'

" live html, css and javascript
Plug 'turbio/bracey.vim', { 'do': 'npm install --prefix server' }

" treesitter
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'

" CSV
Plug 'chrisbra/csv.vim'

" find nested yaml keys
Plug 'munen/find_yaml_key'
" reveal yaml path
Plug 'Einenlum/yaml-revealer'

" figure it out
Plug 'eandrju/cellular-automaton.nvim'

" ChatGPT
Plug 'james1236/backseat.nvim'

call plug#end()
