return {
  {
    "zbirenbaum/copilot.lua",
    event = 'InsertEnter',
    config = function()
      require("copilot").setup({
        -- suggestion = { enabled = false },
        -- panel = { enabled = false },
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>"
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          ["*"] = false,
          python = true,
          lua = true,
          javascript = true,
          typescript = true,
          typescriptreact = true,
          javascriptreact = true,
          elixir = true,
          c = true,
          cpp = true,
          rust = true,
          go = true,
          html = true,
          css = true,
          scss = true,
          json = true,
          yaml = true,
          markdown = true,
          vim = true,
          sh = true,
          dockerfile = true,
          haskell = true,
        }
      })
    end,
  },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   event = 'InsertEnter',
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end
  -- }
}
