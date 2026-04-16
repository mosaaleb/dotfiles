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

  -- colorscheme
  { src = 'https://github.com/navarasu/onedark.nvim' },

  -- quickfix
  { src = 'https://github.com/kevinhwang91/nvim-bqf' },

  -- lsp
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/nvimtools/none-ls.nvim' },
  { src = 'https://github.com/nvimtools/none-ls-extras.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },

  -- completion: native `vim.lsp.completion.enable()` (see lua/plugins/lsp.lua)
  -- snippets: native LSP snippet completions via `vim.snippet` (no engine plugin)

  -- tpope utility belt
  { src = 'https://github.com/tpope/vim-dispatch' },
  { src = 'https://github.com/tpope/vim-unimpaired' },
  { src = 'https://github.com/tpope/vim-projectionist' },
  { src = 'https://github.com/tpope/vim-rake' },
  { src = 'https://github.com/tpope/vim-fugitive' },
  { src = 'https://github.com/tpope/vim-rhubarb' },
  { src = 'https://github.com/tpope/vim-bundler' },
  { src = 'https://github.com/tpope/vim-eunuch' },
  { src = 'https://github.com/tpope/vim-rails' },
  -- surround: using echasnovski/mini.surround (lua, treesitter-aware).
  -- See lua/plugins/surround.lua for mappings (ys/cs/ds preserved).
  -- vim-repeat removed along with vim-surround; mini.surround has built-in
  -- dot-repeat. Plugins that relied on vim-repeat (splitjoin gS/gJ, a few
  -- tpope ones) will lose `.` repeatability for their actions — re-add
  -- `tpope/vim-repeat` if that hurts.

  -- split/join
  { src = 'https://github.com/AndrewRadev/splitjoin.vim' },

  -- fuzzy finder
  { src = 'https://github.com/ctrlpvim/ctrlp.vim' },

  -- git hunks
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },

  -- statusline
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },

  -- auto pairs
  { src = 'https://github.com/jiangmiao/auto-pairs' },

  -- test runner
  { src = 'https://github.com/janko/vim-test' },

  -- ruby ri documentation
  { src = 'https://github.com/danchoi/ri.vim' },

  -- custom textobjects (kept pending mini.ai verification of ao/io on Ruby blocks)
  { src = 'https://github.com/kana/vim-textobj-user' },
  { src = 'https://github.com/nelstrom/vim-textobj-rubyblock' },

  -- tmux
  { src = 'https://github.com/christoomey/vim-tmux-navigator' },
  { src = 'https://github.com/christoomey/vim-tmux-runner' },

  -- treesitter — pinned to master; main-branch rewrite migration is deferred.
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'master' },
  { src = 'https://github.com/echasnovski/mini.ai' },
  { src = 'https://github.com/echasnovski/mini.surround' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },

  -- yaml
  { src = 'https://github.com/cuducos/yaml.nvim' },

  -- rest client
  { src = 'https://github.com/diepm/vim-rest-console' },

  -- markdown preview
  { src = 'https://github.com/toppair/peek.nvim' },
}, { confirm = false })
