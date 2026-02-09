-- Pure vim settings — no plugin dependencies

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

vim.filetype.add({
  extension = {
    mdx = "mdx",
    log = "log",
    conf = "conf",
    env = "dotenv",
  },
  filename = {
    [".env"] = "dotenv",
    ["env"] = "dotenv",
  },
  pattern = {
    ["%.env%.[%w_.-]+"] = "dotenv",
    ["%.certificate%.[%w_.-]+"] = "dotenv",
  },
})

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

-- fold config
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

local wk = require("which-key")

wk.add(
  {
    mode = "n",
    { "<leader>s",  group = "Editor / Filesystem" },
    { "<leader>sc", "<cmd>close<CR>",             desc = "Close current split" },
    { "<leader>se", "<C-w>=",                     desc = "Make splits equal size" },
    { "<leader>ss", "<C-w>s",                     desc = "Split window horizontally" },
    { "<leader>sv", "<C-w>v",                     desc = "Split window vertically" },
    {
      '<leader>sg',
      function()
        if vim.g.maximized then
          vim.cmd('wincmd =')
          vim.g.maximized = false
        else
          vim.cmd('wincmd _ | wincmd |')
          vim.g.maximized = true
        end
      end,
      desc = 'Maximize/minimize split',
    },
    {
      "<leader>sr",
      function()
        wk.show('"')
      end,
      desc = "get register"
    },
    {
      "<leader>sm",
      function()
        wk.show('`')
      end,
      desc = "jump to mark"
    },
  }
)

vim.api.nvim_set_hl(0, "Visual", {
  bg = "#555555",
  blend = 20,
})

-- Pure vim keymaps (no plugin dependencies)
wk.add({
  { "<leader>p",     "\"_dP",  desc = "Pastes preserving register" },
  { "<leader>y",     '"+y',    desc = "Yank to + register" },
  { "<leader>Y",     '"+Y',    desc = "Yank # lines to + register" },
  { "<leader>P",     '"+p',    desc = "Pastes + register" },
  { "<leader><S-d>", "\"_d",   desc = "Deletes preserving register" },
})

wk.add({
  { "<leader>p", "\"_dP", desc = "Pastes preserving register",  mode = "v" },
  { "<leader>y", '"+y',   desc = "Yank to + register",          mode = "v" },
  { "<leader>Y", '"+Y',   desc = "Yank # lines to + register",  mode = "v" },
  { "<leader>d", "\"_d",  desc = "Deletes preserving register", mode = "v" },
})

wk.add({
  { "<C-c>", "<cmd>nohlsearch<CR>", desc = "Remove search" },
  { "<A-K>", "mz<cmd>m-2<cr>`z",    desc = "Move line Up" },
  { "<A-J>", "mz<cmd>m+<cr>`z",     desc = "Move line Down" },
})

wk.add({
  { "d",     "\"_d",                          desc = "Deletes preserving register", mode = "v" },
  { "<A-K>", "<cmd>m'<-2<cr>`>my`<mzgv`yo`z", desc = "Move selected lines up",      mode = "v" },
  { "<A-J>", "<cmd>m'>+<cr>`<my`>mzgv`yo`z",  desc = "Move selected lines down",    mode = "v" },
}, { mode = "v" })
