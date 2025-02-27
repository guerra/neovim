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


    require('which-key').add({
      { "<leader>sp", codesnap.copy_into_clipboard, desc = "Capture code snapshot", mode = "v", nowait = true, remap = false },
    })
  end
}
