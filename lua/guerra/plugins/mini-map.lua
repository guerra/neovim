return {
  'echasnovski/mini.map',
  version = false,
  config = function()
    local map = require('mini.map')
    map.setup({
      symbols = {
        -- Encode symbols. See `:h MiniMap.config` for specification and
        -- `:h MiniMap.gen_encode_symbols` for pre-built ones.
        -- Default: solid blocks with 3x2 resolution.
        encode = nil,

        -- Scrollbar parts for view and line. Use empty string to disable any.
        scroll_line = '█',
        scroll_view = '┃',
      },
    });
    vim.keymap.set('n', '<leader>çm', map.toggle, { desc = "Toggle minimap" })
  end
}
