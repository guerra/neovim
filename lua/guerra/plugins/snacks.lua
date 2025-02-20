return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    -- dashboard = { enabled = true },
    -- indent = { enabled = true },
    -- input = { enabled = true },
    -- notifier = { enabled = true },
    -- quickfile = { enabled = true },
    scroll = { enabled = true },
    -- statuscolumn = { enabled = true },
    -- words = { enabled = true },
    lazygit = { enabled = true },
    gitbrowser = { enabled = true },
    terminal = {
      enabled = true,
      {
        bo = {
          filetype = "snacks_terminal",
        },
        wo = {},
        keys = {
          q = "hide",
          gf = function(self)
            local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
            if f == "" then
              Snacks.notify.warn("No file under cursor")
            else
              self:hide()
              vim.schedule(function()
                vim.cmd("e " .. f)
              end)
            end
          end,
          term_normal = {
            "<esc>",
            function(self)
              self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
              if self.esc_timer:is_active() then
                self.esc_timer:stop()
                vim.cmd("stopinsert")
              else
                self.esc_timer:start(200, 0, function() end)
                return "<esc>"
              end
            end,
            mode = "t",
            expr = true,
            desc = "Double escape to normal mode",
          },
        },
      }
    },
  },
  keys = {
    {
      '<leader>cg',
      function()
        Snacks.lazygit()
      end,
      desc = 'lazygit',
    },
    {
      "<leader>st",
      function()
        Snacks.terminal.toggle()
      end,
      desc = 'toggle term',
    },
    {
      "<leader>sn",
      function()
        Snacks.terminal.open()
      end,
      desc = 'new term',
    }
  }
}
