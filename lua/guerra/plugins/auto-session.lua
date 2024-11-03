return {
  'rmagatti/auto-session',
  config = function()
    local auto_session = require('auto-session')

    auto_session.setup({
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { '~/', '~/downloads/', '~/Downloads', '~/documents' },
    })

    require("which-key").add(
      {
        { "<leader>w",  group = "Session shortcuts" },
        { "<leader>ww", "<cmd>w<CR>",               group = "Save buffer" },
        { "<leader>wa", "<cmd>wa<CR>",              desc = "Save all buffers" },
        { "<leader>wq", "<cmd>qa<CR>",              desc = "Quit all w/o saving" },
        { "<leader>wQ", "<cmd>qa!<CR>",             desc = "Quit all w/o saving ignoring unsaved" },
        { "<leader>wx", "<cmd>xa<CR>",              desc = "Quit all saving" },
        { "<leader>wr", "<cmd>SessionRestore<CR>",  desc = "Restore session for cwd" },
        { "<leader>ws", "<cmd>SessionSave<CR>",     desc = "Save session for auto session root dir" },
      }
    )
  end,
}
