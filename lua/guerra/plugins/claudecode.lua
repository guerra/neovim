return {
  'coder/claudecode.nvim',
  dependencies = { 'folke/snacks.nvim' },
  config = true,
  keys = {
    { '<C-g>',  group = 'AI' },
    { '<C-g>c', '<cmd>ClaudeCode<cr>',            desc = 'Toggle Claude' },
    { '<C-g>f', '<cmd>ClaudeCodeFocus<cr>',        desc = 'Focus Claude' },
    { '<C-g>r', '<cmd>ClaudeCode --resume<cr>',    desc = 'Resume Claude' },
    { '<C-g>n', '<cmd>ClaudeCode --continue<cr>',  desc = 'Continue Claude' },
    { '<C-g>m', '<cmd>ClaudeCodeSelectModel<cr>',  desc = 'Select model' },
    { '<C-g>b', '<cmd>ClaudeCodeAdd %<cr>',        desc = 'Add current buffer' },
    { '<C-g>s', '<cmd>ClaudeCodeSend<cr>',         mode = 'v', desc = 'Send to Claude' },
    {
      '<C-g>s',
      '<cmd>ClaudeCodeTreeAdd<cr>',
      desc = 'Add file',
      ft = { 'NvimTree', 'neo-tree', 'oil', 'minifiles', 'netrw' },
    },
    { '<C-g>a', '<cmd>ClaudeCodeDiffAccept<cr>',   desc = 'Accept diff' },
    { '<C-g>d', '<cmd>ClaudeCodeDiffDeny<cr>',     desc = 'Deny diff' },
  },
}
