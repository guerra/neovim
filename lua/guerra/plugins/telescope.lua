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
    ts.setup {
      defaults = vim.tbl_extend('error', fullscreen_setup, {
        results_title = '',
        sorting_strategy = 'ascending',
        border = { prompt = { 1, 1, 1, 1 }, results = { 1, 1, 1, 1 }, preview = { 1, 1, 1, 1 }, },
      }),
    }
  end,
}
