local wk = require('which-key')
local tc = require('telescope')
local tc_builtin = require('telescope.builtin')
local conform = require('conform')
local ufo = require('ufo')
-- local rest = require('rest-nvim')
-- local dapui = require('dapui')
local get_visual_selection = function()
  vim.cmd('noautocmd normal! "vy"')
  return vim.fn.getreg('v')
end

wk.add(
  {
    { "<leader>o",  group = "Obsidian" },
    { "<leader>oo", "<cmd>ObsidianQuickSwitch<cr>",     desc = "Obsidian Quick Switch" },
    { "<leader>oc", "<cmd>ObsidianNew<cr>",             desc = "Obsidian New" },
    { "<leader>ot", "<cmd>ObsidianNewFromTemplate<cr>", desc = "Obsidian new from template" },
    { "<leader>od", "<cmd>ObsidianDailies<cr>",         desc = "Obsidian dailies" },
  }
)
wk.register({
  v = {
    name = 'Vim actions',
    r = { name = 'Review' },
  },

  g = {
    name = 'Telescope',
    f = { tc_builtin.find_files, 'Find files' },
    J = { tc_builtin.git_files, 'Git file search' },
    H = { tc_builtin.help_tags, 'Vim help' },
    g = { tc_builtin.live_grep, 'Live grep' },
    q = { tc.extensions.aerial.aerial, 'Tags' },
    r = { tc_builtin.lsp_references, 'References' },
    R = { tc.extensions.aerial.aerial, 'Aerial References' },
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
    G = { function()
      local word = vim.fn.expand('<cword>')
      tc_builtin.grep_string { search = word }
    end, 'Live grep current word' },
  },

  ['<space>'] = { tc_builtin.resume, 'Resume' },
  b = { tc_builtin.buffers, 'Buffers' },


  -- debugger
  -- e = {
  --   name = 'Debugger',
  --   t = { dapui.toggle, 'Toggle UI' },
  --   b = { '<cmd>DapToggleBreakpoint<CR>', 'Toggle breakpoint' },
  --   c = { '<cmd>DapContinue<CR>', 'Toggle breakpoint' },
  --   r = { function()
  --     dapui.open({ reset = true })
  --   end, 'Toggle breakpoint' },
  -- },

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

  x = {
    name = 'trouble',
    x = { '<cmd>Trouble diagnostics toggle<cr>', 'Toggle' },
    d = { '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', 'Document Diagnostics' },
    w = { '<cmd>Trouble diagnostics toggle<cr>', 'Workspace Diagnostics' },
    s = { "<cmd>Trouble symbols toggle focus=false<cr>", "Symbols (Trouble)" },
    l = { "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", "LSP Definitions / references " },
    q = { "<cmd>Trouble qflist toggle<cr>", "Quickfix List" },
    L = { "<cmd>Trouble loclist toggle<cr>", "Location List" },
    j = { vim.diagnostic.goto_next, 'Next' },
    k = { vim.diagnostic.goto_prev, 'Previous' },


  },
}, { prefix = '<leader>' })

wk.register({
  p = { '"_dP', 'Pastes preserving register' },
  y = { '"+y', 'Yank to + register' },
  Y = { '"+Y', 'Yank # lines to + register' },
  d = { '"_d', 'Deletes preserving register' },
  g = {
    name = 'Telescope - visual mode',
    l = { tc_builtin.git_bcommits_range, 'git buffer commits range' },
    g = { function()
      local text = get_visual_selection() or ''
      tc_builtin.grep_string { search = text }
    end, 'Live grep selection' },

  },
}, { prefix = '<leader>', mode = 'v' })

wk.register({
  ['<C-c>'] = { '<cmd>nohlsearch<CR>', 'Remove search' },
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
    t = { function()
      vim.o.foldcolumn = vim.o.foldcolumn == '1' and '0' or '1'
      vim.o.signcolumn = vim.o.signcolumn == "yes" and "no" or "yes"
      vim.o.relativenumber = not vim.o.relativenumber
      vim.o.number = not vim.o.number
    end,
      'Toggle line number and fold column',
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
