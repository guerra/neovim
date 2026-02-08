return {
  'milanglacier/minuet-ai.nvim',
  event = 'InsertEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('minuet').setup({
      throttle = 2500,
      debounce = 2000,
      provider = 'openai_compatible',
      provider_options = {
        openai_compatible = {
          model = 'claude-sonnet-4-5-20250929',
          end_point = 'http://localhost:8317/v1/chat/completions',
          api_key = function()
            local f = io.open(os.getenv('HOME') .. '/cliproxyapi/config.yaml', 'r')
            if not f then return '' end
            local content = f:read('*a')
            f:close()
            return content:match('api%-keys:%s*%-%s*"([^"]+)"') or ''
          end,
          name = 'Claude',
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

    local vt = require('minuet.virtualtext')

    require('which-key').add({
      { '<leader>9', group = 'Minuet AI' },
      { '<leader>9t', '<cmd>Minuet virtualtext toggle<cr>', desc = 'Toggle auto-trigger' },
      { '<leader>9n', vt.action.next, desc = 'Trigger / next suggestion', mode = 'i' },
      { '<leader>9p', vt.action.prev, desc = 'Trigger / prev suggestion', mode = 'i' },
    })
  end,
}
