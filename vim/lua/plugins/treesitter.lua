-- nvim-treesitter (main branch) — parsers + queries only.
-- Highlighting is done by nvim core via `vim.treesitter.start()`.
-- The markdown injection workaround from master is unnecessary here: main
-- drops the custom `#set-lang-from-info-string!` directive that crashed
-- nvim 0.12's core injection engine.

-- 'jsonc' is not a distinct parser on main (jsonc uses the json parser).
local parsers = {
  'ruby', 'embedded_template', 'javascript', 'typescript', 'tsx',
  'html', 'css', 'scss', 'json', 'yaml', 'toml',
  'lua', 'vim', 'vimdoc', 'bash', 'sql', 'regex', 'query',
  'markdown', 'markdown_inline', 'gitcommit', 'gitignore', 'diff',
}

-- Install (idempotent — skips parsers already present).
require('nvim-treesitter').install(parsers)

-- Start treesitter highlight for any filetype whose language has a parser.
-- Replaces master's `highlight = { enable = true }` module.
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('TSHighlight', { clear = true }),
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    local lang = vim.treesitter.language.get_lang(ft)
    if lang and pcall(vim.treesitter.language.add, lang) then
      pcall(vim.treesitter.start, args.buf, lang)
    end
  end,
})

-- mini.ai — treesitter-aware text objects.
local ai = require('mini.ai')
ai.setup({
  n_lines = 500,
  custom_textobjects = {
    f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
    c = ai.gen_spec.treesitter({ a = '@class.outer',    i = '@class.inner' }),
    o = ai.gen_spec.treesitter({
      a = { '@block.outer', '@conditional.outer', '@loop.outer' },
      i = { '@block.inner', '@conditional.inner', '@loop.inner' },
    }),
    a = ai.gen_spec.treesitter({ a = '@parameter.outer', i = '@parameter.inner' }),
  },
})

-- Movement keys (buffer-local — override any ftplugin defaults).
local function move(side, id, method)
  return function()
    ai.move_cursor(side, 'a', id, { search_method = method, n_lines = 500 })
  end
end

local function setup_movement_keys(bufnr)
  local opts = function(desc) return { buffer = bufnr, desc = desc } end
  local mode = { 'n', 'x', 'o' }
  vim.keymap.set(mode, ']]', move('left',  'c', 'next'), opts('Next class start'))
  vim.keymap.set(mode, '[[', move('left',  'c', 'prev'), opts('Prev class start'))
  vim.keymap.set(mode, ']m', move('left',  'f', 'next'), opts('Next function start'))
  vim.keymap.set(mode, '[m', move('left',  'f', 'prev'), opts('Prev function start'))
  vim.keymap.set(mode, ']M', move('right', 'f', 'next'), opts('Next function end'))
  vim.keymap.set(mode, '[M', move('right', 'f', 'prev'), opts('Prev function end'))
  vim.keymap.set(mode, '][', move('right', 'c', 'next'), opts('Next class end'))
  vim.keymap.set(mode, '[]', move('right', 'c', 'prev'), opts('Prev class end'))
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('MiniAiMovementKeys', { clear = true }),
  pattern = { 'ruby', 'eruby', 'javascript', 'typescript', 'typescriptreact',
              'javascriptreact', 'lua', 'python', 'go', 'rust', 'html', 'vue' },
  callback = function(args)
    setup_movement_keys(args.buf)
  end,
})
