return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.ai').setup()
    require('mini.surround').setup({
      mappings = {
        add = 'gsa',       -- Add surrounding
        delete = 'gsd',    -- Delete surrounding
        replace = 'gsr',   -- Replace surrounding
        find = 'gsf',      -- Find surrounding (to the right)
        find_left = 'gsF', -- Find surrounding (to the left)
        highlight = 'gsh',
        update_n_lines = 'gsn',
      }
    })

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
    vim.keymap.set('n', '<leader>;', map.toggle, { desc = "Toggle minimap" })
  end,
}
