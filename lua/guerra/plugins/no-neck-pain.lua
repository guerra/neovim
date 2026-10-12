return {
  'shortcuts/no-neck-pain.nvim',
  ft = 'markdown',
  keys = {
    {
      '<leader>zr',
      function()
        require('no-neck-pain')
        if vim.g.nnp_enabled then
          require('no-neck-pain').disable()
        else
          require('no-neck-pain').enable()
        end
      end,
      desc = 'Reading mode',
    },
  },
  config = function()
    local nnp = require('no-neck-pain')

    nnp.setup({
      width = 100,
      autocmds = {
        enableOnVimEnter = false,
        enableOnTabEnter = false,
        skipEnteringNoNeckPainBuffer = true,
      },
      callbacks = {
        postEnable = function()
          vim.g.nnp_enabled = true
        end,
        postDisable = function()
          vim.g.nnp_enabled = false
        end,
      },
    })

    -- Auto-enable for future markdown buffers
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        if not vim.g.nnp_enabled then
          vim.schedule(function()
            nnp.enable()
          end)
        end
      end,
    })

    -- Enable now if current buffer is already markdown (FileType already fired)
    if vim.bo.filetype == 'markdown' then
      vim.schedule(function()
        nnp.enable()
      end)
    end
  end,
}
