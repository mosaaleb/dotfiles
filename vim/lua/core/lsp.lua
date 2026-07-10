-- Native LSP setup — no nvim-lspconfig needed on nvim 0.11+.
-- Per-server configs live in `~/.config/nvim/lsp/<name>.lua` and are read
-- automatically by vim.lsp.enable(name).

-- Global defaults applied to every server (merged before the per-server file).
-- `capabilities` is set by blink.cmp (see lua/plugins/cmp.lua) — it extends
-- the nvim defaults with richer completion/snippet support.
vim.lsp.config('*', {
  root_markers = { '.git' },
})

vim.lsp.enable({
  -- Ruby / Rails
  'ruby_lsp',
  'herb_ls',            -- HTML+ERB (@herb-tools/language-server)
  -- 'stimulus_ls',     -- DISABLED: the npm package stimulus-language-server
  --                      ships a broken `bin` entry (points to ./out/stimulus-language-server
  --                      which isn't in the tarball). Re-enable when upstream
  --                      fixes packaging: https://www.npmjs.com/package/stimulus-language-server

  -- JS / TS / React
  'ts_ls',              -- typescript-language-server
  'eslint',             -- vscode-eslint-language-server (diagnostics + fix-on-save)

  -- Styles / Markup
  'tailwindcss',
  'cssls',              -- vscode-css-language-server
  'html',               -- vscode-html-language-server

  -- Config / Data
  'jsonls',             -- vscode-json-language-server
  'yamlls',             -- yaml-language-server (redhat)
})

-- Diagnostic UI — signs in the gutter + float on CursorHold. No inline noise.
vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = true,
    header = '',
    max_width = 80,
    focusable = false,
    prefix = function(diagnostic)
      local icons = {
        [vim.diagnostic.severity.ERROR] = { '\u{f057}  ', 'DiagnosticError' },
        [vim.diagnostic.severity.WARN]  = { '\u{f071}  ', 'DiagnosticWarn' },
        [vim.diagnostic.severity.INFO]  = { '\u{f05a}  ', 'DiagnosticInfo' },
        [vim.diagnostic.severity.HINT]  = { '\u{f0eb}  ', 'DiagnosticHint' },
      }
      local item = icons[diagnostic.severity]
      return item[1], item[2]
    end,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '\u{f057}',
      [vim.diagnostic.severity.WARN]  = '\u{f071}',
      [vim.diagnostic.severity.INFO]  = '\u{f05a}',
      [vim.diagnostic.severity.HINT]  = '\u{f0eb}',
    },
  },
})

-- Auto-open float for diagnostics under cursor (requires updatetime; set in options.lua).
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  group = vim.api.nvim_create_augroup('UserDiagnosticFloat', { clear = true }),
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false, scope = 'cursor' })
  end,
})

-- Diagnostic navigation: [g prev, ]g next (nvim's native ]d/[d still work).
vim.keymap.set('n', ']g', function() vim.diagnostic.jump({ count = 1, float = true }) end,
  { desc = 'Next diagnostic' })
vim.keymap.set('n', '[g', function() vim.diagnostic.jump({ count = -1, float = true }) end,
  { desc = 'Prev diagnostic' })

-- Per-buffer LSP setup.
-- Keymaps nvim 0.11+ already provides out of the box (DO NOT remap):
--   K         hover
--   grn       rename
--   gra       code action (n + x)
--   grr       references
--   gri       implementation
--   grt       type definition
--   gO        document symbols
--   ]d / [d   next / prev diagnostic
--   <C-s>     signature help (insert)
--
-- We only add mappings for things nvim doesn't provide natively.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspAttach', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then return end

    -- Completion is handled by blink.cmp (see lua/plugins/cmp.lua) — no
    -- need to call vim.lsp.completion.enable() here.

    -- Inlay hints (0.10+). Toggle with <leader>ih.
    if client:supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
      vim.keymap.set('n', '<leader>ih', function()
        vim.lsp.inlay_hint.enable(
          not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }),
          { bufnr = ev.buf }
        )
      end, { buffer = ev.buf, desc = 'Toggle inlay hints' })
    end

    -- Format keymap (no native equivalent in 0.11).
    vim.keymap.set('n', '<leader>ff', function()
      vim.lsp.buf.format({ async = false })
    end, { buffer = ev.buf, desc = 'LSP format' })
  end,
})

-- Completion keymaps live in lua/plugins/cmp.lua (owned by blink.cmp).
