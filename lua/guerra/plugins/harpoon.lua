return {
  'theprimeagen/harpoon',
  config = function()
    require('harpoon').setup({
      menu = {
        width = math.floor(90),
      }
    })
  end,
}
