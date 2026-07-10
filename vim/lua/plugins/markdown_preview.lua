-- Markdown preview via the gh-markdown-preview extension. One server per file.
-- Spawn the extension's shim, not `gh markdown-preview`: gh doesn't forward
-- SIGTERM to the extension, so killing it would leave the server orphaned.

local shim = vim.fn.expand('~/.local/share/gh/extensions/gh-markdown-preview/gh-markdown-preview')
local jobs = {}

local function stop(file)
  if jobs[file] then
    jobs[file]:kill('sigterm')
    jobs[file] = nil
  end
end

local function stop_all()
  for file in pairs(jobs) do
    stop(file)
  end
end

vim.api.nvim_create_user_command('Mdpreview', function()
  local file = vim.api.nvim_buf_get_name(0)
  if jobs[file] then
    return
  end

  vim.cmd.write()

  -- stderr is discarded: the server logs a line per HTTP request.
  jobs[file] = vim.system({ shim, file }, { stderr = false }, function()
    jobs[file] = nil
  end)
end, {})

vim.api.nvim_create_user_command('Mdkill', function()
  stop(vim.api.nvim_buf_get_name(0))
end, {})

vim.api.nvim_create_user_command('Mdkillall', stop_all, {})

vim.api.nvim_create_autocmd('VimLeavePre', { callback = stop_all })
