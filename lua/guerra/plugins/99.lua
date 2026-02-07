return {
  'ThePrimeagen/99',
  event = 'VeryLazy',
  config = function()
    local _99 = require('99')
    _99.setup({})

    require('which-key').add({
      { '<leader>9', group = '99 AI' },
      { '<leader>9f', _99.fill_function, desc = 'Fill function' },
      { '<leader>9v', _99.visual, desc = 'Visual AI', mode = 'v' },
      { '<leader>9s', _99.stop, desc = 'Stop request' },
    })
  end,
}
