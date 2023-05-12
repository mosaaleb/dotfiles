lua << EOF
  require('backseat').setup({
    openai_api_key = 'key here',
    openai_model_id = 'gpt-3.5-turbo', --gpt-4
    -- split_threshold = 100,
    -- additional_instruction = "Respond snarkily", -- (GPT-3 will probably deny this request, but GPT-4 complies)
    -- highlight = {
    --     icon = '', -- ''
    --     group = 'Comment',
    -- }
  })
EOF
