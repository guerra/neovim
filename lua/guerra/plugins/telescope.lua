return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      require('telescope').setup {
        defaults = {
          path_display = {
            filename_first = {
              reverse_directories = true
            }
          },
        }
      }
    end,
  }
}
