return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  config = function()
    local obsidian = require("obsidian")
    obsidian.setup({
      workspaces = {
        {
          name = "personal",
          path = "~/documents/vault/guerra - second mind/",
        },
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      templates = {
        folder = "Templates",
      },
      daily_notes = {
        folder = "daily",
        template = "Daily"
      },
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          suffix = suffix .. title
        end
        return tostring("neovim notes/" .. os.time()) .. "-" .. suffix
      end,
    })

    vim.api.nvim_create_user_command("ObsidianNewFromBuffer", function()
      -- Prompt for the note title
      local title = vim.fn.input("Enter note title: ")
      if title == "" then
        print("Note creation cancelled.")
        return
      end

      -- Yank the entire content of the current buffer
      vim.cmd("normal! ggVGy")

      -- Create a new note with the specified title
      vim.cmd("ObsidianNew " .. title)

      -- Paste the yanked content into the new note
      vim.cmd("normal! ggP")

      -- Save the new note
      vim.cmd("write")
    end, {})
  end
}
