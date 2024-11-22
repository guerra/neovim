return {
  'LukasPietzschmann/telescope-tabs',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('telescope').load_extension('telescope-tabs')
    local tabs = require('telescope-tabs')
    tabs.setup();

    require('which-key').add({
      mode = { 'n' },
      nowait = true,
      remap = false,
      { '<leader>g',  group = 'Telescope' },
      { '<leader>gt', tabs.list_tabs,       desc = 'Find tabs' },
      { '<leader>gT', tabs.go_to_previeous, desc = 'Go to previous tab' },
    })
  end,
}
