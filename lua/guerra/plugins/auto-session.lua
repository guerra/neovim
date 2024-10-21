return {
  'rmagatti/auto-session',
  config = function()
    local auto_session = require('auto-session')

    auto_session.setup({
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { '~/', '~/downloads/', '~/Downloads', '~/documents' },
    })

    local keymap = vim.keymap

    require("which-key").add(
      {
        { "<leader>w",  group = "Session shortcuts" },
        { "<leader>ww", "<cmd>w<CR>",               group = "Save buffer" },
        { "<leader>wa", "<cmd>wa<CR>",              group = "Save all buffers" },
        { "<leader>wr", "<cmd>SessionRestore<CR>",  desc = "Restore session for cwd" },
        { "<leader>ws", "<cmd>SessionSave<CR>",     desc = "Save session for auto session root dir" },
      }
    )
  end,
}
