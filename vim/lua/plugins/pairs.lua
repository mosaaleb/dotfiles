-- mini.pairs — auto-insert closing bracket/quote/backtick.
-- Smarter than auto-pairs: skips insertion when the cursor is inside a
-- string or comment (via treesitter), where a new pair is rarely wanted.

require('mini.pairs').setup({
  modes = { insert = true, command = false, terminal = false },

  -- Match defaults: ( -> (), [ -> [], { -> {}, " -> "", ' -> '', ` -> ``
  -- mini.pairs handles these out of the box; explicit config only needed
  -- for overrides. Example: don't auto-pair `'` in Rust (lifetime prefix).
  mappings = {
    ["'"] = {
      action = 'open',
      pair = "''",
      neigh_pattern = '[^%a\\].',   -- skip if previous char is a letter
      register = { cr = false },
    },
  },
})
