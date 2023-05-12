" Ruby & Ruby on Rails configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim rails and ruby (rake.vim) alternate (test) file
nnoremap <silent> <leader>a :A<CR>

" jumping betweem MVC files (model/view/controller) files
nnoremap <silent> <leader>v :Eview<CR>
nnoremap <silent> <leader>m :Emodel<CR>
nnoremap <silent> <leader>h :Ehelper<CR>
nnoremap <silent> <leader>c :Econtroller<CR>

" restart server
noremap <leader>rs :Rails restart<CR>

" rspec syntax highlight outside of rails projects
augroup RSpecHighlight
  autocmd!

  autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject its shared_examples_for shared_context let
  highlight def link rubyRspec Function
augroup END

" custom projections
let g:rails_projections = {
      \  "app/queries/*_query.rb": {
      \    "command": "query",
      \    "test": [
      \      "spec/queries/{}_query_spec.rb",
      \      "test/queries/{}_query_test.rb"
      \    ],
      \    "alternate": [
      \      "spec/queries/{}_query_spec.rb",
      \      "test/queries/{}_query_test.rb"
      \    ],
      \    "template": "# frozen_string_literal: true\n\n" .
      \      "class {camelcase|capitalize|colons}Query\n" .
      \      "  def initialize; end\n" .
      \      "end"
      \  },
      \  "app/controllers/*_controller.rb": {
      \      "test": [
      \        "spec/requests/{}_spec.rb",
      \        "spec/requests/{}_controller_spec.rb",
      \        "spec/controllers/{}_controller_spec.rb",
      \        "test/controllers/{}_controller_test.rb"
      \      ],
      \      "alternate": [
      \        "spec/requests/{}_spec.rb",
      \        "spec/requests/{}_controller_spec.rb",
      \        "spec/controllers/{}_controller_spec.rb",
      \        "test/controllers/{}_controller_test.rb"
      \      ],
      \   },
      \  "app/models/concerns/*.rb": {
      \      "command": "concern",
      \      "test": "spec/models/concerns/{}_spec.rb",
      \      "alternate": "spec/models/concerns/{}_spec.rb",
      \   },
      \  "app/controllers/concerns/*.rb": {
      \      "command": "concern",
      \      "test": "spec/controllers/concerns/{}_spec.rb",
      \      "alternate": "spec/controllers/concerns/{}_spec.rb",
      \   },
      \   "spec/requests/*_spec.rb": {
      \      "command": "request",
      \      "alternate": "app/controllers/{}_controller.rb",
      \      "template": "require 'rails_helper'\n\n" .
      \        "RSpec.describe '{}' do\nend",
      \   },
      \   "spec/requests/*_controller_spec.rb": {
      \      "command": "request",
      \      "alternate": "app/controllers/{}_controller.rb",
      \      "template": "require 'rails_helper'\n\n" .
      \        "RSpec.describe '{}' do\nend",
      \   },
      \   "app/javascript/controllers/*_controller.js": {
      \     "command": "stimulus",
      \     "template": "import {open} Controller {close} from 'stimulus';\n\n" .
      \       "export default class extends Controller {\n}",
      \   },
      \ }

" vim-ruby settings
let ruby_operators = 1
let ruby_pseudo_operators = 1
let g:rubycomplete_rails = 1
