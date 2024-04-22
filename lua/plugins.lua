return {
  'famiu/bufdelete.nvim',

  {
    'folke/neodev.nvim',
    config = function()
      require('neodev').setup({
        library = { plugins = { "nvim-dap-ui" }, types = true },
      })
    end,
    priority = 1000,
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = { { 'nvim-lua/plenary.nvim' } },
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
  { 'rose-pine/neovim',         name = 'rose-pine' },
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

  -- harpoon
  { 'theprimeagen/harpoon' },
  { 'mbbill/undotree' },

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      --- Uncomment these if you want to manage LSP servers from neovim
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- LSP Support
      { 'neovim/nvim-lspconfig' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'L3MON4D3/LuaSnip' },
    },
  },

  {
    'williamboman/mason.nvim',
    dependencies = {
      { 'williamboman/mason-lspconfig.nvim' },
    },
  },

  'stevearc/conform.nvim',
  'mfussenegger/nvim-lint',

  {
    'cappyzawa/trim.nvim',
    config = function()
      require('trim').setup({})
    end,
  },

  {
    'jackMort/ChatGPT.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },

  -- {
  --   'rest-nvim/rest.nvim',
  --   dependencies = { 'nvim-lua/plenary.nvim' },
  -- },

  {
    'stevearc/aerial.nvim',
  },

  { 'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async' },

  { 'folke/trouble.nvim',    dependencies = 'nvim-tree/nvim-web-devicons' },

  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = 'onedark',
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
        },
      })
    end,
  },

  {
    'folke/noice.nvim',
    config = function()
      require('noice').setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true, -- dependencies hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
      })
    end,
  },

  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup()
    end,
  },

  {
    "github/copilot.vim",
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
    'iamcco/markdown-preview.nvim',
    build = 'cd app & yarn install'
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    'chentoast/marks.nvim',
    config = function()
      require('marks').setup()
    end,
  },

  {
    "microsoft/vscode-js-debug",
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
  },

  'theHamsta/nvim-dap-virtual-text',

  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', "nvim-neotest/nvim-nio" },
    config = function()
      require('dapui').setup()
    end,
  },


  {
    'mxsdev/nvim-dap-vscode-js',
    dependencies = { 'mfussenegger/nvim-dap' },
  },

  {
    'christoomey/vim-tmux-navigator',
  }
}
