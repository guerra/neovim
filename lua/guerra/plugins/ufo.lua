return {
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
  config = function()
    local ufo = require('ufo')

    ufo.setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { 'lsp', 'indent' }
      end,
    })

    local wk = require('which-key')
    wk.add({
      { "z",  group = "fold" },
      { "zM", ufo.closeAllFolds, desc = "Close all folds" },
      { "zR", ufo.openAllFolds,  desc = "Open all folds" },
      {
        "zk",
        function()
          local winid = ufo.peekFoldedLinesUnderCursor()
          if not winid then
            vim.lsp.buf.hover()
          end
        end,
        desc = "Peek fold"
      },
      {
        "zt",
        function()
          vim.o.foldcolumn = vim.o.foldcolumn == '1' and '0' or '1'
          vim.o.signcolumn = vim.o.signcolumn == "yes" and "no" or "yes"
          vim.o.relativenumber = not vim.o.relativenumber
          vim.o.number = not vim.o.number
        end,
        desc = "Toggle line number and fold column"
      },
    })
  end,
}
