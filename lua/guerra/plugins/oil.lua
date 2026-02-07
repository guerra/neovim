return {
  'stevearc/oil.nvim',
  config = function()
    local oil = require('oil')
    oil.setup()

    local wk = require("which-key")
    wk.add({
      mode = "n",
      { "<leader>sO", oil.toggle_float,                     desc = "Open oil in current folder" },
      { "<leader>so", function() oil.toggle_float('.') end, desc = "Open oil" },
    })
  end,
}
