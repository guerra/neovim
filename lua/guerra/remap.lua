local wk = require('which-key')
local tc = require('telescope')
local tc_builtin = require('telescope.builtin')
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')
local term = require('harpoon.term')
local conform = require('conform')
local lint = require('lint')
local rest = require('rest-nvim')
local ufo = require('ufo')
local trouble = require('trouble')

wk.register({
  g = {
    name = 'Telescope',
    f = { tc_builtin.find_files, 'Find files' },
    h = { tc_builtin.git_files, 'Git file search' },
    H = { tc_builtin.help_tags, 'Vim help' },
    g = { tc_builtin.live_grep, 'Live grep' },
    b = { tc_builtin.buffers, 'Buffers' },
    q = { tc.extensions.aerial.aerial, 'Tags' },
    r = { tc_builtin.lsp_references, 'References' },
    o = { tc.extensions.git_worktree.git_worktrees, 'Git worktrees' },
    c = { tc.extensions.git_worktree.create_git_worktree, 'Create git worktree' },
  },
  ['<space>'] = { tc_builtin.resume, 'Resume' },

  -- Harpoon
  h = { ui.nav_next, 'Next Harpoon Mark' },
  l = { ui.nav_prev, 'Prev Harpoon Mark' },
  m = { mark.add_file, 'Add file to harpoon' },
  a = { ui.toggle_quick_menu, 'Open harpoon' },
  ['1'] = {
    function()
      term.gotoTerminal(1)
    end,
    'Open term 1',
  },
  ['2'] = {
    function()
      term.gotoTerminal(2)
    end,
    'Open term 2',
  },
  ['3'] = {
    function()
      term.gotoTerminal(3)
    end,
    'Open term 3',
  },

  -- undotree
  u = { vim.cmd.UndotreeToggle, 'Undo Tree' },

  f = {
    function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end,
    'Format',
  },

  -- delete / yank / paste stuff
  p = { '"_dP', 'Pastes preserving register' },
  y = { '"+y', 'Yank to + register' },
  Y = { '"+Y', 'Yank # lines to + register' },
  P = { '"+p', 'Pastes + register' },
  ['<S-d>'] = { '"_d', 'Deletes preserving register' },

  s = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], 'Replace current word' },
  X = { '<cmd>!chmod +x %<CR>', 'Turns file to executable' },

  j = { '<cmd>bprevious<cr>', 'previous buffer file' },
  k = { '<cmd>bnext<cr>', 'next buffer file' },
  d = { '<cmd>Bdelete<cr>', 'Belete buffer' },
  D = { '<cmd>Bwipeout<cr>', 'delete buffer' },

  c = {
    name = 'ChatGPT',
    c = { '<cmd>ChatGPT<CR>', 'ChatGPT' },
    e = { '<cmd>ChatGPTEditWithInstruction<CR>', 'Edit with instruction', mode = { 'n', 'v' } },
    g = { '<cmd>ChatGPTRun grammar_correction<CR>', 'Grammar Correction', mode = { 'n', 'v' } },
    t = { '<cmd>ChatGPTRun translate<CR>', 'Translate', mode = { 'n', 'v' } },
    k = { '<cmd>ChatGPTRun keywords<CR>', 'Keywords', mode = { 'n', 'v' } },
    ['<C-d>'] = { '<cmd>ChatGPTRun docstring<CR>', 'Docstring', mode = { 'n', 'v' } },
    a = { '<cmd>ChatGPTRun add_tests<CR>', 'Add Tests', mode = { 'n', 'v' } },
    o = { '<cmd>ChatGPTRun optimize_code<CR>', 'Optimize Code', mode = { 'n', 'v' } },
    s = { '<cmd>ChatGPTRun summarize<CR>', 'Summarize', mode = { 'n', 'v' } },
    f = { '<cmd>ChatGPTRun fix_bugs<CR>', 'Fix Bugs', mode = { 'n', 'v' } },
    x = { '<cmd>ChatGPTRun explain_code<CR>', 'Explain Code', mode = { 'n', 'v' } },
    r = { '<cmd>ChatGPTRun roxygen_edit<CR>', 'Roxygen Edit', mode = { 'n', 'v' } },
    l = { '<cmd>ChatGPTRun code_readability_analysis<CR>', 'Code Readability Analysis', mode = { 'n', 'v' } },
  },

  q = {
    name = 'Aerial tags',
    ['<space>'] = { vim.cmd.AerialToggle, 'Toggle tags' },
    j = { vim.cmd.AerialNext, 'Next tag' },
    k = { vim.cmd.AerialPrev, 'Prev tag' },
  },

  w = {
    name = 'Rest',
    r = { rest.run, 'run request' },
  },

  i = {
    function()
      lint.try_lint()
    end,
    'Trigger linting',
  },

  x = {
    name = 'trouble',
    x = {
      function()
        trouble.toggle()
      end,
      'Toggle',
    },
    w = {
      function()
        trouble.toggle('workspace_diagnostics')
      end,
      'Workspace Diagnostics',
    },
    d = {
      function()
        trouble.toggle('document_diagnostics')
      end,
      'Document Diagnostics',
    },
    q = {
      function()
        trouble.toggle('quickfix')
      end,
      'Quickfix',
    },
    l = {
      function()
        trouble.toggle('loclist')
      end,
      'Localtion List',
    },
  },
}, { prefix = '<leader>' })

wk.register({
  p = { '"_dP', 'Pastes preserving register' },
  y = { '"+y', 'Yank to + register' },
  Y = { '"+Y', 'Yank # lines to + register' },
  d = { '"_d', 'Deletes preserving register' },
}, { prefix = '<leader>', mode = 'v' })

wk.register({
  ['<C-c>'] = { '<cmd>nohlsearch<CR>', 'Remove search' },
  ['<c-e>'] = { ui.toggle_quick_menu, 'Open harpoon' },
  ['<A-k>'] = { 'mz<cmd>m-2<cr>`z', 'Move line Up' },
  ['<A-j>'] = { 'mz<cmd>m+<cr>`z', 'Move line Down' },
  z = {
    name = 'fold',
    M = { ufo.closeAllFolds, 'Close all folds' },
    R = { ufo.openAllFolds, 'Open all folds' },
    k = {
      function()
        local winid = ufo.peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end,
      'Peek fold',
    },
  },
}, { prefix = '' })

wk.register({
  -- p = { '"_dP', 'Pastes preserving register' },
  -- y = { '"+y', 'Yank to + register' },
  -- Y = { '"+Y', 'Yank # lines to + register' },
  d = { '"_d', 'Deletes preserving register' },
  ['<A-k>'] = { '<cmd>m\'<-2<cr>`>my`<mzgv`yo`z', 'Move selected lines up' },
  ['<A-j>'] = { '<cmd>m\'>+<cr>`<my`>mzgv`yo`z', 'Move selected lines down' },
}, { prefix = '', mode = 'v' })

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
