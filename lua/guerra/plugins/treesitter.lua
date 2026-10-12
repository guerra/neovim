return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    lazy = false,
    config = function()
      local ts = require('nvim-treesitter')

      ts.install({
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
        'python',
      })

      local available = {}
      for _, lang in ipairs(ts.get_available()) do
        available[lang] = true
      end

      -- Highlight + folds per buffer; parsers missing locally are installed on demand
      -- (replaces master's highlight.enable + auto_install). Without a parser, folds fall
      -- back to indent. LspAttach in lsp.lua upgrades folds to LSP foldingRange.
      local function start(buf)
        if not pcall(vim.treesitter.start, buf) then
          return false
        end
        vim.wo[0][0].foldmethod = 'expr'
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        return true
      end

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(ev)
          if start(ev.buf) then
            return
          end
          vim.wo[0][0].foldmethod = 'indent'
          local lang = vim.treesitter.language.get_lang(ev.match)
          if lang and available[lang] and not vim.list_contains(ts.get_installed(), lang) then
            ts.install(lang):await(vim.schedule_wrap(function()
              if vim.api.nvim_buf_is_valid(ev.buf) and vim.api.nvim_get_current_buf() == ev.buf then
                start(ev.buf)
              end
            end))
          end
        end,
      })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter-textobjects').setup({
        select = {
          lookahead = true,
          selection_modes = {
            ['@parameter.outer'] = 'v',
            ['@function.outer'] = 'V',
          },
          include_surrounding_whitespace = false,
        },
        move = { set_jumps = false },
      })

      local select = require('nvim-treesitter-textobjects.select')
      local move = require('nvim-treesitter-textobjects.move')
      local ts_repeat_move = require('nvim-treesitter-textobjects.repeatable_move')

      local function sel(query, group)
        return function()
          select.select_textobject(query, group or 'textobjects')
        end
      end
      local function mv(fn, query, group)
        return function()
          move[fn](query, group or 'textobjects')
        end
      end

      local loop = { '@loop.inner', '@loop.outer' }

      require('which-key').add({
        {
          mode = { 'x', 'o' },
          { 'aF', sel('@function.outer'), desc = 'Select function (outer)' },
          { 'iF', sel('@function.inner'), desc = 'Select function (inner)' },
          { 'ac', sel('@class.outer'), desc = 'Select class (outer)' },
          { 'ic', sel('@class.inner'), desc = 'Select class (inner)' },
          { 'as', sel('@local.scope', 'locals'), desc = 'Select scope' },
        },
        {
          -- <C-j> = next, <C-k> = prev. Was J*/K* prefixes, which delayed native
          -- J (join) and K (LSP hover); lone <C-j>/<C-k> do nothing useful in normal mode
          mode = { 'n', 'x', 'o' },
          { '<C-j>', group = 'Treesitter next' },
          { '<C-k>', group = 'Treesitter prev' },
          { '<C-j>m', mv('goto_next_start', '@function.outer'), desc = 'Next function start' },
          { '<C-k>m', mv('goto_previous_start', '@function.outer'), desc = 'Prev function start' },
          { '<C-j>M', mv('goto_next_end', '@function.outer'), desc = 'Next function end' },
          { '<C-k>M', mv('goto_previous_end', '@function.outer'), desc = 'Prev function end' },
          { '<C-j>c', mv('goto_next_start', '@class.outer'), desc = 'Next class' },
          { '<C-k>c', mv('goto_previous_start', '@class.outer'), desc = 'Prev class' },
          { '<C-j>l', mv('goto_next_start', loop), desc = 'Next loop' },
          { '<C-k>l', mv('goto_previous_start', loop), desc = 'Prev loop' },
          { '<C-j>s', mv('goto_next_start', '@local.scope', 'locals'), desc = 'Next scope' },
          { '<C-k>s', mv('goto_previous_start', '@local.scope', 'locals'), desc = 'Prev scope' },
          { '<C-j>z', mv('goto_next_start', '@fold', 'folds'), desc = 'Next fold' },
          { '<C-k>z', mv('goto_previous_start', '@fold', 'folds'), desc = 'Prev fold' },
          { '<C-j>d', mv('goto_next', '@conditional.outer'), desc = 'Next conditional' },
          { '<C-k>d', mv('goto_previous', '@conditional.outer'), desc = 'Prev conditional' },

          -- Repeat movement with ; and ,  (builtin f/F/t/T included)
          { ';', ts_repeat_move.repeat_last_move_next, desc = 'Repeat last move' },
          { ',', ts_repeat_move.repeat_last_move_previous, desc = 'Repeat last move (reverse)' },
          { 'f', ts_repeat_move.builtin_f_expr, expr = true, desc = 'f' },
          { 'F', ts_repeat_move.builtin_F_expr, expr = true, desc = 'F' },
          { 't', ts_repeat_move.builtin_t_expr, expr = true, desc = 't' },
          { 'T', ts_repeat_move.builtin_T_expr, expr = true, desc = 'T' },
        },
      })
    end,
  },
}
