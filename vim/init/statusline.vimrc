" statusline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << END

local fugitive_extension = {
  filetypes = { "fugitive" },
  sections = {
    lualine_a = {
      {
        'branch',
        color = { fg = '#ffffff', bg = 'grey20', gui = "bold" }
      }
    }
  }
}

local dirvish_extension = {
  filetypes = { "dirvish" },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      { 'branch', fmt = function(str) return str:sub(4, -1) end },
    },
    lualine_c = {
      { 'filename', path = 1 }
    }
  }
}

require('lualine').setup({
  options = {
    theme = 'onedark',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      { 'branch', fmt = function(str) return str:sub(4, -1) end },
    },
    lualine_c = { 'diagnostics', { 'filename', path = 0 } } ,
    lualine_x = { 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {}, lualine_b = {}, lualine_c = {'filename'},
    lualine_x = {}, lualine_y = {}, lualine_z = {}
  },
  extensions = { fugitive_extension, dirvish_extension, "quickfix" }
})
END

set noshowmode
