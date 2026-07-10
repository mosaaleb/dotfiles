-- mini.surround — replaces tpope/vim-surround.
-- Mappings preserve vim-surround muscle memory:
--   ys{motion}{char}  add surround
--   ds{char}          delete surround
--   cs{from}{to}      replace surround
-- Bonus features from mini.surround:
--   sf{char} / sF{char}   find surround forward/backward (jumps cursor)
--   sh{char}              highlight surround (briefly)
-- Dot-repeat is built-in; no vim-repeat needed.

require('mini.surround').setup({
  mappings = {
    add            = 'ys',   -- vim-surround classic
    delete         = 'ds',
    replace        = 'cs',
    find           = 'sf',
    find_left      = 'sF',
    highlight      = 'sh',
    update_n_lines = '',     -- disabled (we don't change `config.n_lines` on the fly)
    suffix_last    = 'l',    -- `ysal)` surrounds the *last* surround target
    suffix_next    = 'n',    -- `ysan)` surrounds the *next* surround target
  },
  -- `cover_or_next` matches covering the cursor first, then searches forward.
  -- Good match for how most people actually use surround.
  search_method = 'cover_or_next',

  -- Treesitter-aware custom surrounds: pick function/class outer via treesitter
  -- instead of trying to match brackets.
  custom_surroundings = {
    f = {
      -- Surround with a function call: `ysiwf` then type name → name(...)
      input  = { '%f[%w_%.][%w_%.]+%b()', '^.-%(().*()%)$' },
      output = function()
        local name = vim.fn.input('Function name: ')
        if name == '' then return nil end
        return { left = name .. '(', right = ')' }
      end,
    },
  },
})

-- mini.surround's default `s` (which would shadow native `s` substitute) is
-- not remapped above — but we set `s` as a prefix key for `sf`/`sh` only, so
-- `s` alone still works as native substitute.

-- Drop the visual-mode `ys` mapping — it shadows `y` in visual mode, causing
-- a `timeoutlen`-long delay every time you yank a selection. Use `S` for
-- visual-mode surround instead (matches tpope/vim-surround behavior).
vim.keymap.del('x', 'ys')
vim.keymap.set('x', 'S', ':<C-u>lua MiniSurround.add("visual")<CR>',
  { silent = true, desc = 'Add surround to selection' })
