source $HOME/.config/nvim/init/plug.vimrc
source $HOME/.config/nvim/init/search.vimrc
source $HOME/.config/nvim/init/general.vimrc
source $HOME/.config/nvim/init/dirvish.vimrc
source $HOME/.config/nvim/init/theme.vimrc
source $HOME/.config/nvim/init/quickfix.vimrc
source $HOME/.config/nvim/init/statusline.vimrc
source $HOME/.config/nvim/init/nvim-lsp.vimrc
source $HOME/.config/nvim/init/treesitter.vimrc
source $HOME/.config/nvim/init/coc.vimrc
source $HOME/.config/nvim/init/ctrlp.vimrc
source $HOME/.config/nvim/init/autosave.vimrc
source $HOME/.config/nvim/init/ruby-rails.vimrc
source $HOME/.config/nvim/init/vim-test.vimrc
source $HOME/.config/nvim/init/ultisnips.vimrc
source $HOME/.config/nvim/init/tmux.vimrc
source $HOME/.config/nvim/init/git.vimrc
source $HOME/.config/nvim/init/rest.vimrc
source $HOME/.config/nvim/init/seeingisbelieving.vimrc
" source $HOME/.config/nvim/init/backseat.vimrc

lua << EOF
  require('backseat').setup({
    openai_api_key = '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',
    openai_model_id = 'gpt-3.5-turbo', --gpt-4
    -- split_threshold = 100,
    -- additional_instruction = "Respond snarkily", -- (GPT-3 will probably deny this request, but GPT-4 complies)
    -- highlight = {
    --     icon = '', -- ''
    --     group = 'Comment',
    -- }
  })
EOF
