return {
  "olimorris/codecompanion.nvim",
  config = function()
    return require("codecompanion").setup {
      strategies = {
        chat = {
          adapter = "anthropic",
        },
        inline = {
          adapter = "anthropic",
        },
      },
    }
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "markdown", "codecompanion" }
    },
    {
      "echasnovski/mini.diff",
      config = function()
        local diff = require("mini.diff")
        diff.setup({
          -- Disabled by default
          source = diff.gen_source.none(),
        })
      end,
    },
  },
}
