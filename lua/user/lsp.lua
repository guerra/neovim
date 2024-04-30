local lsp_zero = require('lsp-zero')

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

lsp_zero.on_attach(function(client, bufnr)
  if vim.fn.expand('%'):find('^.env.*$') then
    vim.lsp.stop_client(client.id)
  end

  vim.keymap.set('n', 'gd', function()
    vim.lsp.buf.definition()
  end, { buffer = bufnr, remap = false, desc = 'Go to definition' })
  vim.keymap.set('n', '<leader>i', function()
    vim.lsp.buf.hover()
  end, { buffer = bufnr, remap = false, desc = 'Show hover' })
  vim.keymap.set('n', '<leader>vws', function()
    vim.lsp.buf.workspace_symbol()
  end, { buffer = bufnr, remap = false, desc = 'Workspace symbols' })
  vim.keymap.set('n', '<leader>vd', function()
    vim.diagnostic.open_float()
  end, { buffer = bufnr, remap = false, desc = 'Open diagnostics' })
  vim.keymap.set('n', '<leader>vj', function()
    vim.diagnostic.goto_next()
  end, { buffer = bufnr, remap = false, desc = 'Go to next diagnostic' })
  vim.keymap.set('n', '<leader>vk', function()
    vim.diagnostic.goto_prev()
  end, { buffer = bufnr, remap = false, desc = 'Go to previous diagnostic' })
  vim.keymap.set('n', '<leader>vca', function()
    vim.lsp.buf.code_action()
  end, { buffer = bufnr, remap = false, desc = 'Code action' })
  vim.keymap.set('n', '<leader>vrr', function()
    vim.lsp.buf.references()
  end, { buffer = bufnr, remap = false, desc = 'References' })
  vim.keymap.set('n', '<leader>vrn', function()
    vim.lsp.buf.rename()
  end, { buffer = bufnr, remap = false, desc = 'Rename' })
  vim.keymap.set('i', '<C-h>', function()
    vim.lsp.buf.signature_help()
  end, { buffer = bufnr, remap = false, desc = 'Signature help' })
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'tsserver',
    'eslint',
    'lua_ls',
    'gopls',
    'html',
    'htmx',
    'bashls',
    'templ',
    'elixirls',
  },

  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  },
})

cmp.setup({
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
  },
  formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
})
