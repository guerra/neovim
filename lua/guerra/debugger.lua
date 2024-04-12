require("dap-vscode-js").setup({
  debugger_path = "~/.local/share/nvim/lazy/vscode-js-debug", -- Path to vscode-js-debug installation.
  adapters = {
    'chrome',
    'pwa-node',
    'pwa-chrome', 'pwa-msedge',
    'node-terminal',
    'pwa-extensionHost',
    'node', 'chrome'
  }, -- which adapters to register in nvim-dap
})

local js_based_languages = { "typescript", "javascript", "typescriptreact" }

for _, language in ipairs(js_based_languages) do
  require("dap").configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = function()
        require('dap.utils').pick_process({ filter = 'nestjs' })
      end,
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Start Chrome with \"localhost\"",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
    }
  }
end
