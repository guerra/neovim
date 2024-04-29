local wk = require('which-key')
local tc = require('telescope')
local tc_builtin = require('telescope.builtin')
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')
local tmux = require('harpoon.tmux')
local conform = require('conform')
local lint = require('lint')
-- local rest = require('rest-nvim')
local ufo = require('ufo')
local trouble = require('trouble')
local oil = require('oil')
local dapui = require('dapui')

tc.load_extension('harpoon')

wk.register({
  g = {
    name = 'Telescope',
    f = { tc_builtin.find_files, 'Find files' },
    G = { tc_builtin.git_files, 'Git file search' },
    h = { '<cmd>Telescope harpoon marks<cr>', 'Harpoon' },
    H = { tc_builtin.help_tags, 'Vim help' },
    g = { tc_builtin.live_grep, 'Live grep' },
    q = { tc.extensions.aerial.aerial, 'Tags' },
    r = { tc_builtin.lsp_references, 'References' },
    o = { tc.extensions.git_worktree.git_worktrees, 'Git worktrees' },
    c = { tc.extensions.git_worktree.create_git_worktree, 'Create git worktree' },
    n = { tc_builtin.marks, 'Marks' },
    k = { tc_builtin.jumplist, 'Jumplist' },
    l = { tc_builtin.quickfixhistory, 'Quickfix' },
    L = { tc_builtin.registers, 'Registers' },
    j = {
      name = 'git',
      s = { tc_builtin.git_status, 'git status' },
      b = { tc_builtin.git_branches, 'git branches' },
      c = { tc_builtin.git_commits, 'git commits' },
      l = { tc_builtin.git_bcommits, 'git buffer commits' },
    },
  },
  ['<space>'] = { tc_builtin.resume, 'Resume' },
  b = { tc_builtin.buffers, 'Buffers' },

  -- debugger
  e = {
    name = 'Debugger',
    t = { dapui.toggle, 'Toggle UI' },
    b = { '<cmd>DapToggleBreakpoint<CR>', 'Toggle breakpoint' },
    c = { '<cmd>DapContinue<CR>', 'Toggle breakpoint' },
    r = { function()
      dapui.open({ reset = true })
    end, 'Toggle breakpoint' },
  },

  -- Harpoon
  h = { ui.nav_next, 'Next Harpoon Mark' },
  l = { ui.nav_prev, 'Prev Harpoon Mark' },
  m = { mark.add_file, 'Add file to harpoon' },
  a = { ui.toggle_quick_menu, 'Open harpoon' },
  ['1'] = {
    function()
      tmux.gotoTerminal(1)
    end,
    'Open term 1',
  },
  ['2'] = {
    function()
      tmux.gotoTerminal(2)
    end,
    'Open term 2',
  },
  ['3'] = {
    function()
      tmux.gotoTerminal(3)
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

  -- s = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], 'Replace current word' },
  -- X = { '<cmd>!chmod +x %<CR>', 'Turns file to executable' },

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

  t = { "<cmd>NvimTreeToggle<cr>", "Toggle Tree" }, -- create a binding with label
  o = { function() oil.toggle_float('.') end, 'Open oil' },
  O = { oil.toggle_float, 'Open oil' },

  q = {
    name = 'Aerial tags',
    ['<space>'] = { '<cmd>AerialToggle!<CR>', 'Toggle tags' },
    j = { vim.cmd.AerialNext, 'Next tag' },
    k = { vim.cmd.AerialPrev, 'Prev tag' },
  },

  -- w = {
  --   name = 'Rest',
  --   r = { rest.run, 'run request' },
  -- },

  I = {
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
  g = {
    name = 'Telescope - visual mode',
    l = { tc_builtin.git_bcommits_range, 'git buffer commits range' }
  },
}, { prefix = '<leader>', mode = 'v' })

wk.register({
  ['<C-c>'] = { '<cmd>nohlsearch<CR>', 'Remove search' },
  ['<C-e>'] = { ui.toggle_quick_menu, 'Open harpoon' },
  ['<A-K>'] = { 'mz<cmd>m-2<cr>`z', 'Move line Up' },
  ['<A-J>'] = { 'mz<cmd>m+<cr>`z', 'Move line Down' },
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
  -- ['<A-k>'] = { '<cmd>wincmd k<cr>', 'Move up' },
  -- ['<A-j>'] = { '<cmd>wincmd j<cr>', 'Move down' },
  -- ['<A-h>'] = { '<cmd>wincmd h<cr>', 'Move left' },
  -- ['<A-l>'] = { '<cmd>wincmd l<cr>', 'Move right' },
}, { prefix = '' })

wk.register({
  -- p = { '"_dP', 'Pastes preserving register' },
  -- y = { '"+y', 'Yank to + register' },
  -- Y = { '"+Y', 'Yank # lines to + register' },
  d = { '"_d', 'Deletes preserving register' },
  ['<A-K>'] = { '<cmd>m\'<-2<cr>`>my`<mzgv`yo`z', 'Move selected lines up' },
  ['<A-J>'] = { '<cmd>m\'>+<cr>`<my`>mzgv`yo`z', 'Move selected lines down' },
}, { prefix = '', mode = 'v' })

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
