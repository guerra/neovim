return {
  'folke/which-key.nvim',
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300

    local wk = require('which-key')

    wk.setup({
      preset = 'modern',
      expand = 1,
      icons = {
        rules = {
          { pattern = 'find', icon = ' ', color = 'green' },
          { pattern = 'search', icon = ' ', color = 'green' },
          { pattern = 'grep', icon = ' ', color = 'green' },
          { pattern = 'git', icon = ' ', color = 'orange' },
          { pattern = 'lazygit', icon = ' ', color = 'orange' },
          { pattern = 'hunk', icon = ' ', color = 'orange' },
          { pattern = 'blame', icon = ' ', color = 'orange' },
          { pattern = 'diagnostic', icon = ' ', color = 'red' },
          { pattern = 'format', icon = ' ', color = 'cyan' },
          { pattern = 'rename', icon = '󰑕 ', color = 'purple' },
          { pattern = 'buffer', icon = ' ', color = 'azure' },
          { pattern = 'split', icon = ' ', color = 'azure' },
          { pattern = 'terminal', icon = ' ', color = 'grey' },
          { pattern = 'session', icon = ' ', color = 'yellow' },
          { pattern = 'obsidian', icon = '󰠗 ', color = 'purple' },
          { pattern = 'harpoon', icon = '󱡀 ', color = 'cyan' },
          { pattern = 'trouble', icon = ' ', color = 'red' },
          { pattern = 'fold', icon = ' ', color = 'grey' },
          { pattern = 'save', icon = ' ', color = 'green' },
          { pattern = 'quit', icon = '󰗼 ', color = 'red' },
          { plugin = 'telescope.nvim', icon = ' ', color = 'blue' },
        },
      },
    })

    wk.add({
      -- Window hydra: stay in <C-w> mode for repeated window commands
      {
        '<leader>W',
        function()
          wk.show({ keys = '<c-w>', loop = true })
        end,
        desc = 'Window hydra',
        icon = { icon = ' ', color = 'azure' },
      },
      -- Dynamic buffer switcher (numbered quick-pick)
      {
        '<leader>B',
        desc = 'Buffer switch',
        icon = { icon = ' ', color = 'azure' },
        expand = function()
          return require('which-key.extras').expand.buf()
        end,
      },
    })
  end,
}
