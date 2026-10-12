return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dim = { enabled = true },
    indent = { enabled = true, indent = { char = '┊' } },
    input = { enabled = true },
    -- vim.notify is owned by noice (loads later and overrides it anyway)
    notifier = { enabled = false },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    toggle = { enabled = true },
    words = { enabled = true },
    zen = { enabled = true },
    lazygit = { enabled = true },
    gitbrowse = { enabled = true },
    scratch = { enabled = true },
    terminal = {
      enabled = true,
      bo = {
        filetype = 'snacks_terminal',
      },
      wo = {},
      keys = {
        q = 'hide',
        gf = function(self)
          local f = vim.fn.findfile(vim.fn.expand('<cfile>'), '**')
          if f == '' then
            Snacks.notify.warn('No file under cursor')
          else
            self:hide()
            vim.schedule(function()
              vim.cmd('e ' .. vim.fn.fnameescape(f))
            end)
          end
        end,
        term_normal = {
          '<esc>',
          function(self)
            self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
            if self.esc_timer:is_active() then
              self.esc_timer:stop()
              vim.cmd('stopinsert')
            else
              self.esc_timer:start(200, 0, function() end)
              return '<esc>'
            end
          end,
          mode = 't',
          expr = true,
          desc = 'Double escape to normal mode',
        },
      },
    },
  },
  keys = {
    -- Git
    { '<leader>cg', function() Snacks.lazygit() end, desc = 'lazygit' },
    { '<leader>co', function() Snacks.gitbrowse() end, desc = 'Open in browser' },

    -- Terminal
    { '<leader>st', function() Snacks.terminal.toggle() end, desc = 'toggle term' },
    { '<leader>sn', function() Snacks.terminal.open() end, desc = 'new term' },

    -- Buffers
    { '<leader>sx', function() Snacks.bufdelete() end, desc = 'Close buffer' },
    { '<leader>sX', function() Snacks.bufdelete.all() end, desc = 'Close all buffers' },
    { '<leader>j', '<cmd>bprevious<CR>', desc = 'Previous buffer' },
    { '<leader>k', '<cmd>bnext<CR>', desc = 'Next buffer' },

    -- Zen / Focus
    { '<leader>z', group = 'Zen/Focus' },
    { '<leader>zz', function() Snacks.zen() end, desc = 'Zen mode' },
    { '<leader>zd', function() Snacks.dim() end, desc = 'Dim toggle' },
    { '<leader>zZ', function() Snacks.zen.zoom() end, desc = 'Zoom toggle' },

    -- Scratch
    { '<leader>zs', function() Snacks.scratch() end, desc = 'Scratch buffer' },
    { '<leader>zS', function() Snacks.scratch.select() end, desc = 'Select scratch' },

    -- Distraction-free toggle: line numbers, sign/fold columns and indent guides
    {
      'zt',
      function()
        vim.o.foldcolumn = vim.o.foldcolumn == '1' and '0' or '1'
        vim.o.signcolumn = vim.o.signcolumn == 'yes' and 'no' or 'yes'
        vim.o.relativenumber = not vim.o.relativenumber
        vim.o.number = not vim.o.number
        if Snacks.indent.enabled then
          Snacks.indent.disable()
        else
          Snacks.indent.enable()
        end
      end,
      desc = 'Toggle line number and fold column',
    },

    -- Words (LSP references navigation)
    { ']]', function() Snacks.words.jump(vim.v.count1) end, desc = 'Next reference', mode = { 'n', 'x' } },
    { '[[', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev reference', mode = { 'n', 'x' } },
  },
  config = function(_, opts)
    local Snacks = require('snacks')
    Snacks.setup(opts)

    -- Toggles under <leader>n
    require('which-key').add({ '<leader>n', group = 'Toggles' })
    Snacks.toggle.diagnostics():map('<leader>nd')
    Snacks.toggle.inlay_hints():map('<leader>nh')
    Snacks.toggle.treesitter():map('<leader>nt')
    Snacks.toggle.line_number():map('<leader>nl')
    Snacks.toggle.words():map('<leader>nw')
    Snacks.toggle.dim():map('<leader>nD')
    Snacks.toggle.scroll():map('<leader>ns')
    Snacks.toggle.indent():map('<leader>ni')
    Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>nS')
    Snacks.toggle.option('wrap', { name = 'Word Wrap' }):map('<leader>nW')
  end,
}
