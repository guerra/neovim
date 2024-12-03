require('luasnip.loaders.from_vscode').lazy_load()
local lsp_zero = require('lsp-zero')

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
local lua_opts = lsp_zero.nvim_lua_ls()
local luasnip = require('luasnip')

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
  vim.keymap.set('n', '<leader>vl', function()
    vim.lsp.buf.code_action({
      filter = function(a) return a.isPreferred end,
      apply = true
    })
  end, { buffer = bufnr, remap = false, desc = 'call lint fix' })
  vim.keymap.set('n', '<leader>ci', function()
    vim.lsp.buf.code_action({
      context = {
        diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
        only = { "source.fixAll" }
      },
      apply = true
    })
  end, { buffer = bufnr, remap = false, desc = 'Import module under cursor' })

  vim.api.nvim_set_keymap('n', '<leader>ca',
    '<cmd>lua vim.lsp.buf.code_action()<CR>',
    { noremap = true, silent = true, desc = 'Code actions' })
end)

local servers = {
  'ts_ls',
  'eslint',
  'lua_ls',
  'gopls',
  'html',
  'htmx',
  'bashls',
  'templ',
  'elixirls',
  'sqlls',
  'solargraph',
  'intelephense',
}

lua_opts.capabilities = capabilities

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = servers,
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      lspconfig.lua_ls.setup(lua_opts)
      lspconfig['hls'].setup { filetypes = { 'haskell', 'lhaskell', 'cabal' } }
      lspconfig['solargraph'].setup {
        settings = {
          solargraph = {
            autoformat = false,
            bundlerPath = "bundle",
            checkGemVersion = true,
            commandPath = "solargraph",
            completion = true,
            definitions = true,
            diagnostics = true,
            folding = true,
            formatting = false,
            hover = true,
            logLevel = "warn",
            references = true,
            rename = true,
            symbols = true,
            transport = "socket",
            useBundler = true,
          }
        }
      }
    end,
  },
})

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'copilot' },
    { name = 'luasnip' },
  },
  window = {
    completion = {
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -3,
      side_padding = 0,
    },
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      kind.kind = " " .. (strings[1] or "") .. " "
      kind.menu = "    (" .. (strings[2] or "") .. ")"

      return kind
    end,
  },

  -- formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ['<C-i>'] = cmp.mapping.complete(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-p>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(cmp_select)
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-n>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item(cmp_select)
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-o>'] = cmp.mapping.complete(),
  }),
})

local function format_message(message, max_width)
  local formatted_message = {}
  while #message > max_width do
    local part = message:sub(1, max_width)
    local next_part = message:sub(max_width + 1)
    table.insert(formatted_message, part)
    message = next_part
  end
  table.insert(formatted_message, message)
  return table.concat(formatted_message, "\n")
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '● ',
    spacing = 4,
  },
  signs = true,
  underline = true,
  float = {
    border = 'rounded',
    source = 'if_many',
    focusable = false,
    format = function(diagnostic)
      local message = diagnostic.message
      local max_width = 80
      return format_message(message, max_width)
    end,
  },
  update_in_insert = false,
  severity_sort = true,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
