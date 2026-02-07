return {
  'stevearc/aerial.nvim',
  config = function()
    require('aerial').setup({
      backends = { "lsp", "treesitter", "markdown" },
      layout = {
        min_width = { 40, 0.15 },
        preserve_equality = false,
      },
      show_guides = true,
    })

    require('telescope').load_extension('aerial')
  end,
  keys = {
    { "<leader>q",        group = "Aerial tags" },
    { "<leader>q<space>", "<cmd>AerialToggle!<CR>", desc = "Toggle tags" },
    { "<leader>qj",       vim.cmd.AerialNext,       desc = "Next tag" },
    { "<leader>qk",       vim.cmd.AerialPrev,       desc = "Prev tag" },
  },
}
