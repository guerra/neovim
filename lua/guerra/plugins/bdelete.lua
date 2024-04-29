return {
  {
    'famiu/bufdelete.nvim',
    init = function()
      vim.keymap.set('n', '<leader>sx', '<cmd>Bdelete<CR>', { desc = 'Closes buffer and preserves pane' })
      vim.keymap.set('n', '<leader>sX', '<cmd>%Bdelete<CR>', { desc = 'Closes all buffers' })
      vim.keymap.set('n', '<leader>j', '<cmd>bprevious<CR>', { desc = 'Previous buffer file' })
      vim.keymap.set('n', '<leader>k', '<cmd>bnext<CR>', { desc = 'Next buffer file' })
    end,
  }
}
