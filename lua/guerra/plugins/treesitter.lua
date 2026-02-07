return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    priority = 1000,
    config = function()
      local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'bash',
          'elixir',
          'javascript',
          'typescript',
          'ruby',
          'c',
          'lua',
          'vim',
          'vimdoc',
          'query',
          'json',
          'http',
          'markdown',
          'yaml',
          'markdown_inline',
          'ledger',
          'python'
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })

      require('nvim-treesitter.configs').setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["aF"] = { query = "@function.outer", desc = "@function.outer - select function" },
              ["iF"] = { query = "@function.inner", desc = "@function.inner - select function" },
              ["ic"] = { query = "@class.inner", desc = "@class.inner - select class" },
              ["ac"] = { query = "@class.outer", desc = "@class.outer - select class" },
              ["as"] = { query = "@scope", query_group = "locals", desc = "@scope.locals - select scope" },
            },
            selection_modes = {
              ['@parameter.outer'] = 'v',
              ['@function.outer'] = 'V',
            },
            include_surrounding_whitespace = false,
          },

          move = {
            enable = true,
            set_jumps = false,
            goto_next_start = {
              ["Jm"] = { query = "@function.outer", desc = "@function.outer - move to beginning" },
              ["Jl"] = { query = { "@loop.inner", "@loop.outer" }, desc = "@loop.* - move to loop" },
              ["Js"] = { query = { "@scope.inner", "@scope.outer" }, query_group = "locals", desc = "Next scope" },
              ["Jz"] = { query = "@fold", query_group = "folds", desc = "@fold - move to next fold" },
            },
            goto_next_end = {
              ["JM"] = "@function.outer",
            },
            goto_previous_start = {
              ["Km"] = "@function.outer",
              ["Kc"] = "@class.outer",
            },
            goto_previous_end = {
              ["KM"] = "@function.outer",
            },
            goto_next = {
              ["Jd"] = "@conditional.outer",
            },
            goto_previous = {
              ["[d"] = "@conditional.outer",
            }
          },

          lsp_interop = {
            enable = true,
            border = 'none',
            floating_preview_opts = {},
            peek_definition_code = {
              ["<leader>rf"] = { query = "@function.outer", desc = "@function.outer - peek definition" },
              ["<leader>rF"] = { query = "@class.outer", desc = "@class.outer - peek definition" },
            },
          },
        },
      })

      -- Repeat movement with ; and ,
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

      -- Make builtin f, F, t, T also repeatable with ; and ,
      vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
      vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
      vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
      vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
    end,
  },

  { 'nvim-treesitter/playground' },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' }
  },
}
