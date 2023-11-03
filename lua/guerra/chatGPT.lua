local home = vim.fn.expand('$HOME')
require('chatgpt').setup({
  api_key_cmd = 'cat ' .. home .. '/nextcloud/chatgpt/key',
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
  openai_params = {
    model = 'gpt-4-1106-preview',
  },
  openai_edit_params = {
    model = 'gpt-4-1106-preview',
  },
})
