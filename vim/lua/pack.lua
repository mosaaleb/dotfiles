-- Plugin manifest — native vim.pack (Neovim 0.12+)
-- Post-install hooks (e.g. peek `deno task build:fast`, treesitter `:TSUpdate`)
-- are not inline like vim-plug. Run them manually after first install, or
-- register an autocmd on `PackChanged` for the specific plugin.
--
-- confirm=false: auto-install new plugins on startup without a confirmation
-- prompt. The prompt hangs in headless mode and is noisy in interactive use.

vim.pack.add({
  { src = 'https://github.com/Exafunction/codeium.vim' },

  { src = 'https://github.com/justinmk/vim-dirvish' },

  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },

  -- colorschemes
  { src = 'https://github.com/navarasu/onedark.nvim' },
  { src = 'https://github.com/Shatur/neovim-ayu' },
  { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },

  -- quickfix
  { src = 'https://github.com/kevinhwang91/nvim-bqf' },

  -- lsp
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/nvimtools/none-ls.nvim' },
  { src = 'https://github.com/nvimtools/none-ls-extras.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },

  -- completion
  { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
  { src = 'https://github.com/hrsh7th/cmp-buffer' },
  { src = 'https://github.com/hrsh7th/cmp-path' },
  { src = 'https://github.com/hrsh7th/cmp-cmdline' },
  { src = 'https://github.com/hrsh7th/nvim-cmp' },
  { src = 'https://github.com/quangnguyen30192/cmp-nvim-ultisnips' },

  -- snippets
  { src = 'https://github.com/SirVer/ultisnips' },
  { src = 'https://github.com/honza/vim-snippets' },

  -- tpope utility belt
  { src = 'https://github.com/tpope/vim-obsession' },
  { src = 'https://github.com/tpope/vim-dispatch' },
  { src = 'https://github.com/tpope/vim-unimpaired' },
  { src = 'https://github.com/tpope/vim-projectionist' },
  { src = 'https://github.com/tpope/vim-rake' },
  { src = 'https://github.com/tpope/vim-fugitive' },
  { src = 'https://github.com/tpope/vim-rhubarb' },
  { src = 'https://github.com/tpope/vim-bundler' },
  { src = 'https://github.com/tpope/vim-eunuch' },
  { src = 'https://github.com/tpope/vim-rails' },
  { src = 'https://github.com/tpope/vim-surround' },
  { src = 'https://github.com/tpope/vim-repeat' },

  -- split/join
  { src = 'https://github.com/AndrewRadev/splitjoin.vim' },

  -- sql formatter
  { src = 'https://github.com/vim-scripts/SQLUtilities' },
  { src = 'https://github.com/vim-scripts/Align' },

  -- fuzzy finder
  { src = 'https://github.com/ctrlpvim/ctrlp.vim' },

  -- gitgutter
  { src = 'https://github.com/airblade/vim-gitgutter' },

  -- statusline
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },

  -- tags management
  { src = 'https://github.com/ludovicchabant/vim-gutentags' },

  -- auto pairs
  { src = 'https://github.com/jiangmiao/auto-pairs' },

  -- ruby
  { src = 'https://github.com/vim-ruby/vim-ruby' },

  -- test runner
  { src = 'https://github.com/janko/vim-test' },

  -- ruby ri documentation
  { src = 'https://github.com/danchoi/ri.vim' },

  -- custom textobjects
  { src = 'https://github.com/kana/vim-textobj-user' },
  { src = 'https://github.com/nelstrom/vim-textobj-rubyblock' },

  -- tmux
  { src = 'https://github.com/christoomey/vim-tmux-navigator' },
  { src = 'https://github.com/christoomey/vim-tmux-runner' },

  -- treesitter — pinned to master; main-branch rewrite migration is deferred.
  -- playground consumes master's `define_modules` API and breaks on main.
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'master' },
  { src = 'https://github.com/nvim-treesitter/playground' },
  { src = 'https://github.com/echasnovski/mini.ai' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },

  -- yaml
  { src = 'https://github.com/cuducos/yaml.nvim' },

  -- figure it out
  { src = 'https://github.com/eandrju/cellular-automaton.nvim' },

  -- rest client
  { src = 'https://github.com/diepm/vim-rest-console' },

  -- markdown preview
  { src = 'https://github.com/toppair/peek.nvim' },
}, { confirm = false })
