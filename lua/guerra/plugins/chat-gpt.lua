return {
  'jackMort/ChatGPT.nvim',
  event = "VeryLazy",
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local home = vim.fn.expand('$HOME')
    require('chatgpt').setup({
      api_key_cmd = 'cat ' .. home .. '/nextcloud/chatgpt/key',
      openai_params = {
        model = 'gpt-4-turbo-preview',
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 3000,
        temperature = 0,
        top_p = 1,
        n = 1,
      },
      openai_edit_params = {
        model = 'gpt-4-turbo-preview',
        frequency_penalty = 0,
        presence_penalty = 0,
        temperature = 0,
        top_p = 1,
        n = 1,
      },
      edit_with_instructions = {
        diff = false,
        keymaps = {
          close = '<C-c>',
          accept = '<C-y>',
          toggle_diff = '<C-d>',
          toggle_settings = '<C-o>',
          cycle_windows = '<Tab>',
          use_output_as_input = '<C-i>',
        },
      },
    })
  end
}
