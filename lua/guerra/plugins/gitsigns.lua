return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require 'gitsigns'.setup()

    require("which-key").add({
      {
        mode = { "n" },
        nowait = true,
        remap = false,
        { "<leader>c",   group = "Coding / Repo" },
        { "<leader>cp",  ":Gitsigns preview_hunk<cr>",              desc = "Toggle preview hunk" },
        { "<leader>ct",  ":Gitsigns preview_hunk_inline<cr>",       desc = "Preview hunk inline" },
        { "<leader>cb",  ":Gitsigns toggle_current_line_blame<cr>", desc = "Toggle current line blame" },
        { "<leader>cj",  ":Gitsigns next_hunk<cr>",                 desc = "Next hunk" },
        { "<leader>ck",  ":Gitsigns prev_hunk<cr>",                 desc = "Previous hunk" },
        { "<leader>cd",  ":Gitsigns diffthis<cr>",                  desc = "Diff this" },
        { "<leader>cD",  ":Gitsigns toggle_deleted<cr>",            desc = "Toggle deleted" },
        { "<leader>cll", ":Gitsigns setloclist<cr>",                desc = "Loc list" },
        { "<leader>clf", ":Gitsigns setloclist<cr>",                desc = "Fix list" },
      }
    })
  end
}
