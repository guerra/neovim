return {
  'stevearc/conform.nvim',
  config = function()
    local conform = require('conform')

    conform.setup({
      formatters_by_ft = {
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        graphql = { 'prettier' },
        lua = { 'stylua' },
        elixir = { 'mix' },
        shell = { 'shfmt' },
        bash = { 'shfmt' },
        sh = { 'shfmt' },
        haskell = { 'fourmolu' },
        go = { "gofumpt", "goimports", },
        ruby = { "rubyfmt" },
        templ = { "templ" },
        python = { "ruff" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 2000,
      },
    })
  end,
  keys = {
    {
      "<leader>f",
      function()
        require('conform').format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end,
      desc = "Format"
    },
  },
}
