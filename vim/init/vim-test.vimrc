" test.vim configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let test#strategy = 'vtr'
nnoremap <silent> <leader>l    :TestLast<CR>
nnoremap <silent> <leader>tf   :TestFile<CR>
nnoremap <silent> <leader>s    :TestSuite<CR>
nnoremap <silent> <leader>t    :TestNearest<CR>

let test#ruby#rails#executable = 'docker-compose exec web bundle exec rspec --format documentation'
let test#ruby#rspec#executable = 'docker-compose exec web bundle exec rspec --format documentation'

function! ToggleAutoTest()
  if !exists('#AutoTestLast#BufWrite')
    augroup AutoTestLast
      autocmd!
      autocmd BufWrite * if test#exists() |
            \   TestLast |
            \ endif
    augroup END
  else
    augroup AutoTestLast
      autocmd!
    augroup END
  endif
endfunction
command! ToggleAutoTest :call ToggleAutoTest()
