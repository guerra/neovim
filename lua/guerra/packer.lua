vim.cmd([[packadd packer.nvim]])
local packer = require('packer')
packer.util = require('packer.util')

return packer.startup({
  function(use)
    -- Packer can manage itself
    use('wbthomason/packer.nvim')

    use('famiu/bufdelete.nvim')

    use({
      'nvim-telescope/telescope.nvim',
      requires = { { 'nvim-lua/plenary.nvim' } },
    })

    use({ 'axkirillov/easypick.nvim', requires = 'nvim-telescope/telescope.nvim' })

    -- all keybindings here
    use({
      'folke/which-key.nvim',
      config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
      end,
    })

    -- color schemes
    use({ 'rose-pine/neovim', as = 'rose-pine' })
    use({ 'rebelot/kanagawa.nvim', as = 'kanagawa' })

    -- treesitter
    use({ 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } })
    use({ 'nvim-treesitter/playground' })

    -- harpoon
    use({ 'theprimeagen/harpoon' })
    use({ 'mbbill/undotree' })

    use({
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v3.x',
      requires = {
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
    })

    use({
      'williamboman/mason.nvim',
      requires = {
        { 'williamboman/mason-lspconfig.nvim' },
      },
    })

    use('stevearc/conform.nvim')
    use('mfussenegger/nvim-lint')

    use({
      'cappyzawa/trim.nvim',
      config = function()
        require('trim').setup({})
      end,
    })

    use({
      'jackMort/ChatGPT.nvim',
      config = function()
        require('chatgpt').setup()
      end,
      requires = {
        'MunifTanjim/nui.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
      },
    })

    use({
      'rest-nvim/rest.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
    })

    use({
      'stevearc/aerial.nvim',
    })

    use({ 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' })

    use({ 'folke/trouble.nvim', requires = 'nvim-tree/nvim-web-devicons' })

    use({
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
              {
                'buffers',
              },
            },
          },
        })
      end,
    })

    use({
      "folke/noice.nvim",
      config = function()
        require('noice').setup({
          lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
              ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
              ["vim.lsp.util.stylize_markdown"] = true,
              ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
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
      end
    })


    use({
      "stevearc/oil.nvim",
      config = function()
        require("oil").setup()
      end,
    })
  end,
  config = {},
})
