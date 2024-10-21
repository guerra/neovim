return {
  'mistricky/codesnap.nvim',
  build = 'make',
  config = function()
    local codesnap = require('codesnap')
    codesnap.setup({
      mac_window_bar = false,
      has_line_number = true,
      watermark = '',
      bg_padding = 15,
      bg_theme = 'dusk'
    })

    require('which-key').register({
      mode = 'v',
      nowait = true,
      remap = false,
      ['<leader>sp'] = { codesnap.copy_into_clipboard, 'Capture code snapshot' }
    })
  end
}
