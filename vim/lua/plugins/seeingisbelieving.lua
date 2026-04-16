-- seeing_is_believing integration (Ruby inline eval annotations)
-- Assumes `seeing_is_believing` is available in PATH.

local function without_changing_cursor(fn)
  local cursor_pos = vim.fn.getpos('.')
  local wintop_pos = vim.fn.getpos('w0')
  local old_lazyredraw = vim.o.lazyredraw
  vim.o.lazyredraw = true

  fn()

  vim.fn.setpos('.', wintop_pos)
  vim.fn.setpos('.', cursor_pos)
  vim.cmd('redraw')
  vim.o.lazyredraw = old_lazyredraw
end

local function sib_annotate_all(scope)
  without_changing_cursor(function()
    vim.cmd(scope .. '!seeing_is_believing --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk')
  end)
end

local function sib_annotate_marked(scope)
  without_changing_cursor(function()
    vim.cmd(scope .. '!seeing_is_believing --xmpfilter-style --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk')
  end)
end

local function sib_clean_annotations(scope)
  without_changing_cursor(function()
    vim.cmd(scope .. '!seeing_is_believing --clean')
  end)
end

local function sib_toggle_mark()
  local pos = vim.fn.getpos('.')
  local line = vim.fn.getline('.')
  if line:match('^%s*$') then
    line = '# => '
  elseif line:match('# =>') then
    line = line:gsub(' *# =>.*', '')
  else
    line = line .. '  # => '
  end
  vim.fn.setline('.', line)
  vim.fn.setpos('.', pos)
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('SeeingIsBelieving', { clear = true }),
  pattern = 'ruby',
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }
    local nmap = function(lhs, rhs) vim.keymap.set('n', lhs, rhs, opts) end
    local vmap = function(lhs, rhs) vim.keymap.set('v', lhs, rhs, opts) end

    nmap('<Leader>n', function() sib_annotate_all('%') end)
    nmap('<Leader>b', function() sib_annotate_marked('%') end)
    nmap('<Leader>v', function() sib_clean_annotations('%') end)
    nmap('<Enter>',   sib_toggle_mark)
    vmap('<Enter>',   sib_toggle_mark)

    vmap('<Leader>n', function() sib_annotate_all("'<,'>") end)
    vmap('<Leader>b', function() sib_annotate_marked("'<,'>") end)
    vmap('<Leader>v', function() sib_clean_annotations("'<,'>") end)
  end,
})
