return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'folke/noice.nvim' },
  config = function()
    require('lualine').setup({
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = {
          { 'filename' },
          {
            'buffers',
          },
        },
        lualine_x = {
          {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
            color = { fg = "#ff9e64" },
          }
        },
      }
    })
  end,
}
