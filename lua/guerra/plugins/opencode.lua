return {
  'nickjvandyke/opencode.nvim',
  dependencies = { 'folke/snacks.nvim' },
  event = 'VeryLazy',
  config = function()
    vim.o.autoread = true

    require('which-key').add({
      { '<C-x>',  function() require('opencode').select() end,  mode = { 'n', 'x' }, desc = 'OpenCode action' },
      { '<C-.>',  function() require('opencode').toggle() end,  mode = { 'n', 't' }, desc = 'Toggle OpenCode' },
      {
        'go',
        function() return require('opencode').operator('@this ') end,
        mode = { 'n', 'x' },
        desc = 'Send to OpenCode',
        expr = true,
      },
    })
  end,
}
