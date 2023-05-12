" use ack instead of grep for grepping
if executable('ack')
  set grepprg=ack\ -s\ -H\ --nopager\ --nocolor\ --nogroup\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" use ag instead of grep
" if executable('ag')
"   set grepprg=ag\ --nopager\ --nocolor\ --nogroup\ --column
"   set grepformat=%f:%l:%c:%m,%f:%l:%m
" endif

" grep current word
noremap <Leader>\ :grep -r <cword><CR>
" grep template command
noremap <Leader>x :grep -r "" .<left><left><left>
" replace template :cdo s/word/another//gc | update
noremap <Leader>rep :cdo s/\(<c-r>=expand("<cword>")<cr>\)//gc <bar> update<left><left><left><left><left><left><left><left><left><left><left><left>
