return {
  'milanglacier/minuet-ai.nvim',
  event = 'InsertEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('minuet').setup({
      throttle = 3000,
      debounce = 2500,
      provider = 'openai_compatible',
      provider_options = {
        openai_compatible = {
          model = 'qwen3.5-plus',
          end_point = 'https://opencode.ai/zen/go/v1/chat/completions',
          api_key = 'OPENCODE_ZEN_API_KEY',
          name = 'OpencodeGo',
          stream = true,
          optional = {
            max_tokens = 256,
          },
        },
      },
      virtualtext = {
        auto_trigger_ft = { '*' },
        keymap = {
          accept = '<A-l>',
          dismiss = '<C-]>',
          accept_line = '<A-a>',
          prev = '<A-[>',
          next = '<A-]>',
        },
      },
    })

    -- Enable auto-trigger for the current buffer (FileType already fired before plugin loaded)
    vim.b.minuet_virtual_text_auto_trigger = true

    -- Manual trigger/cycle lives on <A-[>/<A-]> (keymap above); <leader>9 belongs to 99.lua
    require('which-key').add({
      { '<leader>nm', '<cmd>Minuet virtualtext toggle<cr>', desc = 'Toggle Minuet auto-trigger' },
    })
  end,
}
