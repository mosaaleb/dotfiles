-- Ruby & Ruby on Rails — vim-rails + vim-ruby + vim-projectionist

local map = vim.keymap.set

-- alternate (test) file
map('n', '<leader>a', ':A<CR>', { silent = true })

-- MVC jumps
map('n', '<leader>v', ':Eview<CR>',       { silent = true })
map('n', '<leader>m', ':Emodel<CR>',      { silent = true })
map('n', '<leader>h', ':Ehelper<CR>',     { silent = true })
map('n', '<leader>c', ':Econtroller<CR>', { silent = true })

-- restart rails server
map('', '<leader>rs', ':Rails restart<CR>')

-- rspec syntax highlight outside of rails projects
vim.api.nvim_create_autocmd('BufRead', {
  group = vim.api.nvim_create_augroup('RSpecHighlight', { clear = true }),
  pattern = '*_spec.rb',
  callback = function()
    vim.cmd([[syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject its shared_examples_for shared_context let]])
  end,
})
vim.cmd('highlight default link rubyRspec Function')

-- vim-ruby settings
vim.g.ruby_operators = 1
vim.g.ruby_pseudo_operators = 1
vim.g.rubycomplete_rails = 1

-- Custom projections for vim-projectionist
vim.g.rails_projections = {
  ['app/queries/*_query.rb'] = {
    command = 'query',
    test = {
      'spec/queries/{}_query_spec.rb',
      'test/queries/{}_query_test.rb',
    },
    alternate = {
      'spec/queries/{}_query_spec.rb',
      'test/queries/{}_query_test.rb',
    },
    template = '# frozen_string_literal: true\n\n' ..
      'class {camelcase|capitalize|colons}Query\n' ..
      '  def initialize; end\n' ..
      'end',
  },
  ['app/strategies/*_strategy.rb'] = {
    command = 'strategy',
    test = {
      'spec/strategies/{}_strategy_spec.rb',
      'test/queries/{}_strategy_test.rb',
    },
    alternate = {
      'spec/strategies/{}_strategy_spec.rb',
      'test/strategies/{}_strategy_test.rb',
    },
    template = '# frozen_string_literal: true\n\n' ..
      'class {camelcase|capitalize|colons}Strategy\n' ..
      '  def initialize; end\n' ..
      'end',
  },
  ['app/controllers/*_controller.rb'] = {
    test = {
      'spec/requests/{}_spec.rb',
      'spec/requests/{}_controller_spec.rb',
      'spec/controllers/{}_controller_spec.rb',
      'test/controllers/{}_controller_test.rb',
    },
    alternate = {
      'spec/requests/{}_spec.rb',
      'spec/requests/{}_controller_spec.rb',
      'spec/controllers/{}_controller_spec.rb',
      'test/controllers/{}_controller_test.rb',
    },
  },
  ['app/models/concerns/*.rb'] = {
    command = 'concern',
    test = {
      'spec/models/concerns/{}_spec.rb',
      'test/models/concerns/{}_test.rb',
    },
    alternate = {
      'spec/models/concerns/{}_spec.rb',
      'test/models/concerns/{}_test.rb',
    },
  },
  ['app/controllers/concerns/*.rb'] = {
    command = 'concern',
    test = 'spec/controllers/concerns/{}_spec.rb',
    alternate = 'spec/controllers/concerns/{}_spec.rb',
  },
  ['spec/requests/*_spec.rb'] = {
    command = 'request',
    alternate = 'app/controllers/{}_controller.rb',
    template = "require 'rails_helper'\n\n" ..
      "RSpec.describe '{}' do\nend",
  },
  ['spec/requests/*_controller_spec.rb'] = {
    command = 'request',
    alternate = 'app/controllers/{}_controller.rb',
    template = "require 'rails_helper'\n\n" ..
      "RSpec.describe '{}' do\nend",
  },
  ['app/javascript/controllers/*_controller.js'] = {
    command = 'stimulus',
    template = "import {open} Controller {close} from 'stimulus';\n\n" ..
      'export default class extends Controller {\n}',
  },
}
