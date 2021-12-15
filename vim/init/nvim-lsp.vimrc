" nvim-lsp configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lua << EOF
" -- disable virtual_text, enable both underline and signs
" vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
"   vim.lsp.diagnostic.on_publish_diagnostics, {
"     signs = true,
"     underline = true,
"     virtual_text = false,
"   }
" )

" require('lspconfig').solargraph.setup{}
" require('lspconfig').tsserver.setup{}
" EOF

" " show diagnostics when hover
" autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({ focusable = false })

" " mappings
" nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>

" " diagnostics
" nnoremap <silent> [g <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
" nnoremap <silent> ]g <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" " formattting
" nnoremap <silent> <leader>ff <cmd>lua vim.lsp.buf.formatting()<CR>
" nnoremap <silent> <leader>ft <cmd>lua vim.lsp.buf.range_formatting()<CR>
" xmap     <silent> <leader>ft <cmd>lua vim.lsp.buf.range_formatting()<CR>

