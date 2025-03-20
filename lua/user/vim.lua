vim.filetype.add({
  -- Detect and assign filetype based on the extension of the filename
  extension = {
    mdx = "mdx",
    log = "log",
    conf = "conf",
    env = "dotenv",
  },

  -- Detect and apply filetypes based on the entire filename
  filename = {
    [".env"] = "dotenv",
    ["env"] = "dotenv",
  },
  -- Detect and apply filetypes based on certain patterns of the filenames
  pattern = {
    -- INFO: Match filenames like - ".env.example", ".env.local" and so on
    ["%.env%.[%w_.-]+"] = "dotenv",
    ["%.certificate%.[%w_.-]+"] = "dotenv",
  },
})

-- vim.cmd('colorscheme kanagawa-wave')
vim.cmd('colorscheme rose-pine-moon')

vim.opt.guicursor = ''

vim.opt.nu = true
vim.opt.relativenumber = true

-- tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = '120'

-- fold config
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

local oil = require('oil')
local whichkey = require("which-key")

whichkey.add(
  {
    mode = "n",
    { "<leader>s",  group = "Editor / Filesystem" },
    { "<leader>sO", oil.toggle_float,                     desc = "Open oil in current folder" },
    { "<leader>sc", "<cmd>close<CR>",                     desc = "Close current split" },
    { "<leader>se", "<C-w>=",                             desc = "Make splits equal size" },
    { "<leader>so", function() oil.toggle_float('.') end, desc = "Open oil" },
    { "<leader>ss", "<C-w>s",                             desc = "Split window horizontally" },
    { "<leader>sv", "<C-w>v",                             desc = "Split window vertically" },
    {
      "<leader>sr",
      function()
        whichkey.show('"')
      end,
      desc = "get register"
    },
    {
      "<leader>sm",
      function()
        whichkey.show('`')
      end,
      desc = "jump to mark"
    },
  }
)

vim.api.nvim_set_hl(0, "Visual", {
  bg = "#555555", -- pick a color
  blend = 20,     -- or 0–100, where 0 is fully opaque and 100 is fully transparent
})
-- vim.cmd [[
--   highlight Normal guibg=none
--   highlight NonText guibg=none
--   highlight NormalNC guibg=none
--   highlight Normal ctermbg=none
--   highlight NonText ctermbg=none
--   highlight NormalNC ctermbg=none
--   highlight NormalFloat guibg=none
--   highlight NormalFloat ctermbg=none
--   highlight FloatBorder guibg=none
--   highlight FloatBorder ctermbg=none
-- ]]
