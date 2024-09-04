return {
  'chentoast/marks.nvim',
  config = function()
    local marks = require('marks')
    marks.setup(
      {
        mappings = {
          next = false,
          prev = false
        }
      }
    )
    require("which-key").add({
      {
        mode = { "n" },
        nowait = true,
        remap = false,
        { "<leader>L", marks.next, desc = "next mark" },
        { "<leader>H", marks.prev, desc = "prev mark" },
      }
    })
  end
}
