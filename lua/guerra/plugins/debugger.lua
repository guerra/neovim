return {
  {
    "microsoft/vscode-js-debug",
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
  },

  'theHamsta/nvim-dap-virtual-text',

  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', "nvim-neotest/nvim-nio" },
    config = function()
      require('dapui').setup()
    end,
  },


  {
    'mxsdev/nvim-dap-vscode-js',
    dependencies = { 'mfussenegger/nvim-dap' },
  }
}
