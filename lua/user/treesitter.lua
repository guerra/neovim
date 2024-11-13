local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

require('nvim-treesitter.configs').setup({
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
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
    'ledger'
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
})

require 'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- ["af"] = { query = "@function.outer", desc = "@function.outer - select function" },
        -- ["if"] = { query = "@function.inner", desc = "@function.inner - select function" },
        -- ["av"] = { query = "@parameter.outer", desc = "@parameter.outer - select parameter" },
        -- ["iv"] = { query = "@parameter.inner", desc = "@parameter.inner - select parameter" },
        ["ic"] = { query = "@class.inner", desc = "@class.inner - select class" },
        ["ac"] = { query = "@class.outer", desc = "@class.outer - select class" },
        ["as"] = { query = "@scope", query_group = "locals", desc = "@scope.locals - select scope" },
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V',  -- linewise
        --['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true or false
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
      -- Below will go to either the start or the end, whichever is closer.
      -- Use if you want more granular movements
      -- Make it even more gradual by adding multiple queries and regex.
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

    -- swap = {
    --   enable = true,
    --   swap_next = {
    --     ["C-a"] = "@parameter.inner",
    --   },
    --   swap_previous = {
    --     ["C-A"] = "@parameter.inner",
    --   },
    -- },
  },
}


-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- vim way: ; goes to the direction you were moving.
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
