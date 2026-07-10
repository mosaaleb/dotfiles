-- blink.cmp — completion engine. Replaces native vim.lsp.completion.enable().
-- Keymaps preserved from the old pumvisible mappings:
--   <C-j>     next item
--   <C-k>     prev item
--   <Tab>     accept selection
--   <C-e>     cancel / hide menu
--   <C-Space> force-show menu (or toggle docs panel)

require('blink.cmp').setup({
  keymap = {
    preset = 'none',
    ['<C-j>']     = { 'select_next', 'fallback' },
    ['<C-k>']     = { 'select_prev', 'fallback' },
    ['<Tab>']     = { 'select_and_accept', 'fallback' },
    ['<C-e>']     = { 'hide', 'fallback' },
    ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
  },

  appearance = { nerd_font_variant = 'mono' },

  completion = {
    list = {
      selection = {
        preselect   = true,   -- highlight first item when menu opens
        auto_insert = false,  -- don't insert until <Tab>
      },
    },

    menu = {
      border = 'rounded',
    },

    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = { border = 'rounded' },
    },
  },

  signature = { enabled = true, window = { border = 'rounded' } },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  -- Lua fuzzy matcher — no Rust binary download/compile required.
  -- See pack.lua note for switching to the Rust implementation.
  fuzzy = { implementation = 'lua' },
})

-- Extend every LSP server's capabilities with blink's additions
-- (richer snippet support, additionalTextEdits, etc.).
vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})
