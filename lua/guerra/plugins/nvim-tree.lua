return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      actions = {
        open_file = {
          resize_window = false
        }
      },
      view = {
        side = "right",
        width = 50,
      },
    })
  end
}
