return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", 'atidyshirt/harpoon-tmux', },
  config = function()
    local harpoon = require("harpoon")
    local harpoon_tmux = require('harpoon-tmux');
    harpoon:setup({
      ['tmux'] = harpoon_tmux.build_list()
    })

    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end

    harpoon:extend({
      UI_CREATE = function(cx)
        vim.keymap.set("n", "<C-v>", function()
          harpoon.ui:select_menu_item({ vsplit = true })
        end, { buffer = cx.bufnr })

        vim.keymap.set("n", "<C-x>", function()
          harpoon.ui:select_menu_item({ split = true })
        end, { buffer = cx.bufnr })
      end,
    })

    require('which-key').add(
      {
        mode = { "n" },
        nowait = true,
        remap = false,
        { "<leader>A",  function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "toggle quick menu" },
        { "<C-e>",      function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "toggle quick menu" },
        { "<leader>m",  function() harpoon:list():add() end,                         desc = "add to harpoon list" },
        { "<leader>h",  function() harpoon:list():prev() end,                        desc = "harpoon previous" },
        { "<leader>l",  function() harpoon:list():next() end,                        desc = "harpoon next" },
        { "<leader>gh", function() toggle_telescope(harpoon:list()) end,             desc = "harpoon telescope" },
        { "<leader>1",  function() harpoon_tmux.go_to_terminal(2) end,               desc = "harpoon term 1" },
        { "<leader>2",  function() harpoon_tmux.go_to_terminal(3) end,               desc = "harpoon term 2" },
        { "<leader>3",  function() harpoon_tmux.go_to_terminal(4) end,               desc = "harpoon term 3" },
      }
    )
  end,
}
