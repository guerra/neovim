local get_visual_selection = function()
  vim.cmd('noautocmd normal! "vy"')
  return vim.fn.getreg('v')
end

return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local ts = require('telescope')
    local h_percentage = 0.85
    local w_percentage = 0.85
    local w_limit = 80
    --vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")
    local standard_setup = {
      borderchars = {
        --           N    E    S    W   NW   NE   SE   SW
        prompt = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        results = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      },
      preview = { hide_on_startup = true },
      layout_strategy = 'vertical', -- HORIZONTAL, VERTICAL, FLEX
      layout_config = {
        vertical = {
          mirror = true,
          prompt_position = 'top',
          width = function(_, cols, _)
            return math.min(math.floor(w_percentage * cols), w_limit)
          end,
          height = function(_, _, rows)
            return math.floor(rows * h_percentage)
          end,
          preview_cutoff = 10,
          preview_height = 0.4,
        },
      },
    }
    local fullscreen_setup = {
      borderchars = {
        --           N    E    S    W   NW   NE   SE   SW
        prompt = { ' ', ' ', '─', ' ', ' ', ' ', ' ', ' ' },
        results = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
        preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      },
      preview = { hide_on_startup = false },
      layout_strategy = 'flex', -- HORIZONTAL, VERTICAL, FLEX
      layout_config = {
        flex = { flip_columns = 100 },
        horizontal = {
          mirror = false,
          prompt_position = 'top',
          width = function(_, cols, _)
            return cols
          end,
          height = function(_, _, rows)
            return rows
          end,
          preview_cutoff = 10,
          preview_width = 0.5,
        },
        vertical = {
          mirror = true,
          prompt_position = 'top',
          width = function(_, cols, _)
            return cols
          end,
          height = function(_, _, rows)
            return rows
          end,
          preview_cutoff = 10,
          preview_height = 0.4,
        },
      },
    }
    ts.setup({
      extensions = {
        aerial = {
          col1_width = 4,
          col2_width = 30,
          format_symbol = function(symbol_path, filetype)
            if filetype == "json" or filetype == "yaml" then
              return table.concat(symbol_path, ".")
            else
              return symbol_path[#symbol_path]
            end
          end,
          show_columns = "both",
        },
      },
      defaults = vim.tbl_extend('error', fullscreen_setup, {
        results_title = '',
        sorting_strategy = 'ascending',
        border = { prompt = { 1, 1, 1, 1 }, results = { 1, 1, 1, 1 }, preview = { 1, 1, 1, 1 }, },
      }),
    })
  end,
  keys = {
    { "<leader>g",   group = "Telescope" },
    { "<leader>gf",  function() require('telescope.builtin').find_files() end,            desc = "Find files" },
    { "<leader>gJ",  function() require('telescope.builtin').git_files() end,             desc = "Git file search" },
    { "<leader>gH",  function() require('telescope.builtin').help_tags() end,             desc = "Vim help" },
    { "<leader>gg",  function() require('telescope.builtin').live_grep() end,             desc = "Live grep" },
    { "<leader>gq",  function() require('telescope').extensions.aerial.aerial() end,      desc = "Tags" },
    { "<leader>gr",  function() require('telescope.builtin').lsp_references() end,        desc = "References" },
    { "<leader>gR",  function() require('telescope').extensions.aerial.aerial() end,      desc = "Aerial References" },
    { "<leader>go",  function() require('telescope').extensions.git_worktree.git_worktrees() end,       desc = "Git worktrees" },
    { "<leader>gc",  function() require('telescope').extensions.git_worktree.create_git_worktree() end, desc = "Create git worktree" },
    { "<leader>gn",  function() require('telescope.builtin').marks() end,                 desc = "Marks" },
    { "<leader>gk",  function() require('telescope.builtin').jumplist() end,              desc = "Jumplist" },
    { "<leader>gl",  function() require('telescope.builtin').quickfixhistory() end,       desc = "Quickfix" },
    { "<leader>gL",  function() require('telescope.builtin').registers() end,             desc = "Registers" },

    { "<leader>gj",  group = "git" },
    { "<leader>gjs", function() require('telescope.builtin').git_status() end,            desc = "git status" },
    { "<leader>gjb", function() require('telescope.builtin').git_branches() end,          desc = "git branches" },
    { "<leader>gjc", function() require('telescope.builtin').git_commits() end,           desc = "git commits" },
    { "<leader>gjl", function() require('telescope.builtin').git_bcommits() end,          desc = "git buffer commits" },

    {
      "<leader>gG",
      function()
        local word = vim.fn.expand('<cword>')
        require('telescope.builtin').grep_string { search = word }
      end,
      desc = "Live grep current word"
    },

    { "<leader><space>", function() require('telescope.builtin').resume() end,  desc = "Resume" },
    { "<leader>b",       function() require('telescope.builtin').buffers() end, desc = "Buffers" },

    { "<leader>g",  group = "Telescope - visual mode", mode = "v" },
    { "<leader>gl", function() require('telescope.builtin').git_bcommits_range() end, desc = "git buffer commits range", mode = "v" },
    {
      "<leader>gg",
      function()
        local text = get_visual_selection() or ""
        require('telescope.builtin').grep_string { search = text }
      end,
      desc = "Live grep selection",
      mode = "v"
    },
  },
}
