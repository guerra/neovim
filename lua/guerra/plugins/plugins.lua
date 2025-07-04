return {
  {
    'folke/neodev.nvim',
    config = function()
      require('neodev').setup({
        library = { plugins = { "nvim-dap-ui" }, types = true },
      })
    end,
    priority = 1000,
  },

  { 'axkirillov/easypick.nvim', dependencies = 'nvim-telescope/telescope.nvim' },

  -- all keybindings here
  {
    'folke/which-key.nvim',
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },

  -- color schemes
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup({
        disable_float_background = true,
      })
    end
  },
  { 'rebelot/kanagawa.nvim',    name = 'kanagawa' },
  {
    'NLKNguyen/papercolor-theme',
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    --   vim.opt.background = 'dark'
    --   vim.cmd([[colorscheme PaperColor]])
    -- end,
    name = 'papercolor'
  },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    priority = 1000,
  },

  { 'nvim-treesitter/playground' },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' }
  },

  { 'mbbill/undotree' },

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      --- Uncomment these if you want to manage LSP servers from neovim
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- LSP Support
      {
        'neovim/nvim-lspconfig',
        version = "*"
      },

      -- Autocompletion
      {
        'hrsh7th/nvim-cmp',
        dependencies = {
          'onsails/lspkind.nvim',
          'hrsh7th/cmp-nvim-lsp-signature-help'
        }
      },
      {
        'hrsh7th/cmp-path',
      },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'saadparwaiz1/cmp_luasnip' },
      {
        'L3MON4D3/LuaSnip',
        version = "v2.*",
        build = "make install_jsregexp",
      }
    },
  },

  {
    'williamboman/mason.nvim',
    dependencies = {
      { 'williamboman/mason-lspconfig.nvim' },
    },
  },

  'stevearc/conform.nvim',
  {
    'cappyzawa/trim.nvim',
    config = function()
      require('trim').setup({})
    end,
  },

  -- {
  --   'rest-nvim/rest.nvim',
  --   dependencies = { 'nvim-lua/plenary.nvim' },
  -- },

  {
    'stevearc/aerial.nvim',
  },

  { 'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async' },

  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = '|',
          section_separators = '',
        },
        sections = {
          lualine_a = {
            { 'filename' },
            {
              'buffers',
            },
          },
          lualine_x = {
            {
              require("noice").api.statusline.mode.get,
              cond = require("noice").api.statusline.mode.has,
              color = { fg = "#ff9e64" },
            }
          },
        }
      })
    end,
  },

  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup()
    end,
  },

  -- {
  --   "sourcegraph/sg.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", --[[ "nvim-telescope/telescope.nvim ]] },

  --   -- If you have a recent version of lazy.nvim, you don't need to add this!
  --   build = "nvim -l build/init.lua",
  -- },

  'ThePrimeagen/git-worktree.nvim',
  'tpope/vim-fugitive',


  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    'alexghergh/nvim-tmux-navigation',
    config = function()
      local nvim_tmux_nav = require('nvim-tmux-navigation')

      vim.keymap.set('n', "<A-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set('n', "<A-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set('n', "<A-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set('n', "<A-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
      vim.keymap.set('n', "<A-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
      vim.keymap.set('n', "<A-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
    end
  },
}
