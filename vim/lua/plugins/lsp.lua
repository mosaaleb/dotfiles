vim.lsp.enable({ 'ruby_lsp', 'tailwindcss', 'cssls' })

vim.keymap.set('n', '[g', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Native LSP autocompletion (0.11+). autotrigger fires on trigger chars
    -- (., ::, etc. advertised by the server). <C-x><C-o> works as fallback.
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = true })
    end

    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gH', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gR', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>ff', function()
      vim.lsp.buf.format({ async = false })
    end, opts)
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
