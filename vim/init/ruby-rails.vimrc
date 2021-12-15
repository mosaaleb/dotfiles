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
      \        "spec/controllers/{}_controller_spec.rb",
      \        "test/controllers/{}_controller_test.rb"
      \      ],
      \      "alternate": [
      \        "spec/requests/{}_spec.rb",
      \        "spec/controllers/{}_controller_spec.rb",
      \        "test/controllers/{}_controller_test.rb"
      \      ],
      \   },
      \  "app/concerns/*.rb": {
      \      "command": "concern",
      \      "test": "spec/concerns/{}_spec.rb",
      \      "alternate": "spec/concerns/{}_spec.rb",
      \   },
      \  "app/components/*_component.rb": {
      \      "command": "component",
      \      "type": "component",
      \      "test": [
      \         "spec/components/{}_component_spec.rb",
      \         "test/components/{}_component_test.rb"
      \      ],
      \      "alternate": [
      \         "spec/components/{}_component_spec.rb",
      \         "test/components/{}_component_test.rb"
      \      ],
      \     "template": "# frozen_string_literal: true\n\n" .
      \       "class {camelcase|capitalize|colons}Component < ViewComponent::Base\n" .
      \       "  def initialize; end\n" .
      \       "end"
      \   },
      \   "app/components/*_component/*_component.html.erb": {
      \     "type": "componentview", "affinity": "model"
      \   },
      \   "app/components/*_component/*_component.scss": {
      \     "type": "componentstylesheet", "affinity": "model"
      \   },
      \   "spec/requests/*_spec.rb": {
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
      \   "app/javascript/components/*.js": {
      \     "command": "react",
      \     "template": "import React from 'react';\n\n" .
      \       "const {capitalize} = () => (\n" .
      \       "\t<div>This is {capitalize}</div>\n);" .
      \       "\n\nexport default {capitalize};"
      \   }
      \ }

" vim-ruby settings
let ruby_operators = 1
let ruby_pseudo_operators = 1
let g:rubycomplete_rails = 1
