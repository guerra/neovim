return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-jest',
  },
  config = function()
    local neotest = require('neotest')
    neotest.setup({
      adapters = {
        require('neotest-jest')({
          jestCommand = "npm run test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),
      },
    })

    require('which-key').add({
      {
        mode = { 'n' },
        nowait = true,
        remap = false,
        { '<leader>t', group = 'Testing' },
        {
          '<leader>tw',
          function()
            neotest.run.run({ jestCommand = "npm run test:watch -- " })
          end,
          desc = 'Run Jest Watch',
        },
        {
          '<leader>tT',
          function()
            neotest.run.run(vim.fn.expand("%"))
          end,
          desc = 'Run Jest on current file',
        },
        {
          '<leader>tt',
          function()
            neotest.run.run()
          end,
          desc = 'Run closest test',
        },
        {
          '<leader>ts',
          neotest.summary.toggle,
          desc = 'Toggle test summary',
        },
        {
          '<leader>tO',
          neotest.output_panel.toggle,
          desc = 'Open test output',
        },
        {
          '<leader>to',
          neotest.output.open,
          desc = 'Toggle test output',
        },
        {
          '<leader>tc',
          neotest.run.clear,
          desc = 'Clear test results',
        },
        {
          '<leader>tl',
          function()
            neotest.jump.next({ status = 'failed' })
          end,
          desc = 'Jump to next failed test',
        },
        {
          '<leader>th',
          function()
            neotest.jump.prev({ status = 'failed' })
          end,
          desc = 'Jump to prev failed test',
        },
      }
    })
  end
}
