require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'ruby', 'embedded_template', 'javascript', 'typescript', 'tsx',
    'html', 'css', 'scss', 'json', 'jsonc', 'yaml', 'toml',
    'lua', 'vim', 'vimdoc', 'bash', 'sql', 'regex', 'query',
    'markdown', 'markdown_inline', 'gitcommit', 'gitignore', 'diff',
  },
  auto_install = true,
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
})

-- Override the shipped markdown injections query.
-- nvim-treesitter's version uses the custom directive `#set-lang-from-info-string!`
-- which nvim 0.12 core doesn't understand, causing a `nil:range()` crash.
-- This override uses the standard `@injection.language` capture instead.
vim.treesitter.query.set('markdown', 'injections', [[
(fenced_code_block
  (info_string
    (language) @injection.language)
  (code_fence_content) @injection.content)

((html_block) @injection.content
  (#set! injection.language "html")
  (#set! injection.combined)
  (#set! injection.include-children))

((minus_metadata) @injection.content
  (#set! injection.language "yaml")
  (#offset! @injection.content 1 0 -1 0)
  (#set! injection.include-children))

((plus_metadata) @injection.content
  (#set! injection.language "toml")
  (#offset! @injection.content 1 0 -1 0)
  (#set! injection.include-children))

([(inline) (pipe_table_cell)] @injection.content
  (#set! injection.language "markdown_inline"))
]])

local ai = require('mini.ai')
ai.setup({
  n_lines = 500,
  custom_textobjects = {
    f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
    c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
    o = ai.gen_spec.treesitter({
      a = { '@block.outer', '@conditional.outer', '@loop.outer' },
      i = { '@block.inner', '@conditional.inner', '@loop.inner' },
    }),
    a = ai.gen_spec.treesitter({ a = '@parameter.outer', i = '@parameter.inner' }),
  },
})

local function move(side, id, method)
  return function()
    ai.move_cursor(side, 'a', id, { search_method = method, n_lines = 500 })
  end
end

-- vim-ruby's ftplugin sets buffer-local ]]/[[ using `searchsyn()` which
-- requires legacy syntax groups that don't exist under treesitter highlight.
-- Setting mini.ai keymaps via a FileType autocmd makes them buffer-local
-- and ensures they override the ftplugin mappings.
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
