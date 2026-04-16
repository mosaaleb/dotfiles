local fugitive_extension = {
  filetypes = { 'fugitive' },
  sections = {
    lualine_a = {
      { 'branch', color = { fg = '#ffffff', bg = 'grey20', gui = 'bold' } },
    },
  },
}

local dirvish_extension = {
  filetypes = { 'dirvish' },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      { 'branch', color = { fg = '#ffffff', bg = 'grey20', gui = 'bold' } },
    },
    lualine_c = {
      { 'filename', path = 1 },
    },
  },
}

require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'onedark',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      { 'branch', fmt = function(str) return str:sub(5, 8) end, color = { fg = '#ffffff', gui = 'bold' } },
    },
    lualine_c = { 'diagnostics', { 'filename', path = 1 } },
    lualine_x = { 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = {
      {
        function() return 'A' end,
        color = { fg = '#8FBCBB' },
        cond = function() return _G.aider_background_status == 'idle' end,
      },
      {
        function() return 'A' end,
        color = { fg = '#BF616A' },
        cond = function() return _G.aider_background_status == 'working' end,
      },
    },
  },
  inactive_sections = {
    lualine_a = {}, lualine_b = {}, lualine_c = { 'filename' },
    lualine_x = {}, lualine_y = {}, lualine_z = {},
  },
  extensions = { fugitive_extension, dirvish_extension, 'quickfix' },
})
