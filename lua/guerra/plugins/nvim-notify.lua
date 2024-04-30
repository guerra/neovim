return {
  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup({
        stages = 'static',
        timeout = 1000,
      })
    end,
  }
}
