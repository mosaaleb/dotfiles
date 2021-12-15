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

require('lualine').setup({
  options = {
    theme = 'iceberg_dark',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      { 'branch', fmt = function(str) return str:sub(0, 8) end }
    },
    lualine_c = { { 'filename', path = 1 } } ,
    lualine_x = { 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {}, lualine_b = {}, lualine_c = {'filename'},
    lualine_x = {}, lualine_y = {}, lualine_z = {}
  },
  extensions = { fugitive_extension, "quickfix" }
})
END

set noshowmode
" set laststatus=2

" function! CurrentWorkingDirectory()
"   return fnamemodify(getcwd(), ':t')
" endfunction

" function! ReadOnly()
"   if &readonly || !&modifiable
"     return '  '
"   else
"     return ''
" endfunction

" function! GitInfo()
"   let git = fugitive#head()
"   if git != ''
"     return strpart(' '.fugitive#head(), 0, 20)
"   else
"     return ''
" endfunction

" function! IsCurrentWindow()
" 	return getwinvar(winnr(), 'curr')
" endfunction

" let g:currentmode={
"     \ 'n'      : 'NORMAL',
"     \ 'v'      : 'VISUAL',
"     \ 'V'      : 'V·LINE',
"     \ "\<C-V>" : 'V·Block',
"     \ 's'      : 'SELECT',
"     \ 'S'      : 'S·LINE',
"     \ "\<C-S>" : 'S·BLOCK',
"     \ 'i'      : 'INSERT',
"     \ 'R'      : 'REPLACE',
"     \ 'Rv'     : 'V·REPLACE',
"     \ 'c'      : 'COMMAND'
"     \}

" let g:statusline_bg = "#0c0c0c"
" let g:statusline_active_fg = "#6d7d7d"
" let g:statusline_inactive_fg = "#404040"
" let g:statusline_active_block_bg = "#6d7d7d"
" let g:statusline_active_block_fg = "#0c0c0c"
" let g:statusline_inactive_block_bg = "#282929"
" let g:statusline_inactive_block_fg = "#828282"

" execute 'hi User1 guibg=' . g:statusline_bg 'guifg=' . g:statusline_active_fg
" execute 'hi User2 guibg=' . g:statusline_active_block_bg   ' guifg=' . g:statusline_active_block_fg ' gui=bold'
" execute 'hi User3 guibg=' . g:statusline_inactive_block_bg ' guifg=' . g:statusline_inactive_block_fg

" execute 'hi StatusLine   guibg=' . g:statusline_bg ' guifg=' . g:statusline_active_fg
" execute 'hi StatusLineNC guibg=' . g:statusline_bg ' guifg=' . g:statusline_inactive_fg

" set statusline=
" " left side [mode | gitinfo | relative file path | modified flag]
" set statusline+=%2*%{IsCurrentWindow()?'\ \ '.g:currentmode[mode()].'\ ':''}%*
" set statusline+=%3*%{IsCurrentWindow()?'':'\ \ '.g:currentmode[mode()].'\ '}%*
" set statusline+=%3*%{GitInfo()==''?'':'\ \ '.GitInfo().'\ '}%*
" set statusline+=%1*\ %f\ %*
" set statusline+=%1*\ %m\ %*

" " right side [readonly? | line number | percentage | working directory]
" set statusline+=%=
" set statusline+=%1*\ %{ReadOnly()}\ %*
" set statusline+=%1*\ %l/%L\ %*
" set statusline+=%1*\ %p%%\ \ %*
" set statusline+=%2*%{IsCurrentWindow()?'\ '.CurrentWorkingDirectory().'\ ':''}%*%<
" set statusline+=%3*%{IsCurrentWindow()?'':'\ '.CurrentWorkingDirectory().'\ '}%*%<

" augroup StatusLineReload
" 	autocmd!
" 	autocmd CmdwinLeave,bufLeave,WinLeave * call setwinvar(winnr(), 'curr', 0)
" 	autocmd CmdwinEnter,bufEnter,WinEnter * call setwinvar(winnr(), 'curr', 1)
" augroup END
