require('aerial').setup({
  backends = { "lsp", "treesitter", "markdown" },
  layout = {
    min_width = { 40, 0.15 },
    preserve_equality = false,
  },
  show_guides = true,
})
