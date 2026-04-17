-- Native LSP setup — no nvim-lspconfig needed on nvim 0.11+.
-- Per-server configs live in `~/.config/nvim/lsp/<name>.lua` and are read
-- automatically by vim.lsp.enable(name).

-- Global defaults applied to every server (merged before the per-server file).
vim.lsp.config('*', {
  root_markers = { '.git' },
  capabilities = vim.lsp.protocol.make_client_capabilities(),
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

-- Diagnostic UI
vim.diagnostic.config({
  virtual_text = false,                         -- inline one-liners off
  virtual_lines = { current_line = true },      -- full diagnostic on cursor line
  severity_sort = true,
  float = { border = 'rounded' },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = 'E',
      [vim.diagnostic.severity.WARN]  = 'W',
      [vim.diagnostic.severity.INFO]  = 'I',
      [vim.diagnostic.severity.HINT]  = 'H',
    },
  },
})

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

    -- Native autocompletion (0.11+). Triggers on LSP trigger chars.
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = true })
    end

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

-- Completion-menu keymaps: when the popup is visible, remap to native
-- next/prev/confirm. When no popup, keys fall through to their normal
-- insert-mode behavior.
local function map_when_pum(key, action)
  vim.keymap.set('i', key, function()
    return vim.fn.pumvisible() == 1 and action or key
  end, { expr = true })
end

map_when_pum('<C-j>', '<C-n>')  -- next item
map_when_pum('<C-k>', '<C-p>')  -- prev item
map_when_pum('<Tab>',  '<C-y>') -- confirm selection
-- <C-e> is native cancel in insert-mode popup — no remap needed.
