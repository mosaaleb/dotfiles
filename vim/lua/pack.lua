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

  -- lsp: native `vim.lsp.config` + `vim.lsp.enable` (see lua/core/lsp.lua).
  -- nvim-lspconfig is kept purely as a config-data provider — it ships
  -- `lsp/*.lua` files on runtimepath that `vim.lsp.enable()` reads natively.
  -- No `require('lspconfig').setup{}` calls — pure native API.
  -- Our own `lsp/<name>.lua` takes precedence if we need to override.
  { src = 'https://github.com/neovim/nvim-lspconfig' },

  -- completion: native `vim.lsp.completion.enable()` (see lua/core/lsp.lua)
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

  -- fuzzy finder
  { src = 'https://github.com/ctrlpvim/ctrlp.vim' },

  -- git hunks
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },

  -- auto pairs (via echasnovski/mini.pairs — treesitter-aware)
  { src = 'https://github.com/echasnovski/mini.pairs' },
  -- text objects: via mini.ai (treesitter-aware). `ao`/`io` covers Ruby blocks,
  -- `af`/`if` functions, `ac`/`ic` classes, `aa`/`ia` parameters.
  { src = 'https://github.com/echasnovski/mini.ai' },

  -- surround: using echasnovski/mini.surround (lua, treesitter-aware).
  -- See lua/plugins/surround.lua for mappings (ys/cs/ds preserved).
  { src = 'https://github.com/echasnovski/mini.surround' },

  -- test runner
  { src = 'https://github.com/janko/vim-test' },


  -- tmux
  { src = 'https://github.com/christoomey/vim-tmux-navigator' },
  { src = 'https://github.com/christoomey/vim-tmux-runner' },

  -- treesitter — on `main` branch (the rewrite). Provides parsers + queries;
  -- highlighting is done by nvim core via `vim.treesitter.start()`.
  -- nvim-treesitter-textobjects kept for its query files that mini.ai reads
  -- via gen_spec.treesitter (@function.outer, @class.outer, @block.outer, etc).
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },


  -- yaml
  { src = 'https://github.com/cuducos/yaml.nvim' },

  -- markdown preview
  { src = 'https://github.com/toppair/peek.nvim' },
}, { confirm = false })
