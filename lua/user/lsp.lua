require('luasnip.loaders.from_vscode').lazy_load()
local lsp_zero = require('lsp-zero')
local cmp = require('cmp')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
local luasnip = require('luasnip')
local lua_opts = lsp_zero.nvim_lua_ls()

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
  vim.keymap.set('n', '<leader>vl', function()
    vim.lsp.buf.code_action({
      filter = function(a) return a.isPreferred end,
      apply = true
    })
  end, { buffer = bufnr, remap = false, desc = 'call lint fix' })
  vim.keymap.set('n', '<leader>ci', function()
    vim.lsp.buf.code_action({
      context = {
        diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 }),
        only = { "source.fixAll" }
      },
      apply = true
    })
  end, { buffer = bufnr, remap = false, desc = 'Import module under cursor' })
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
  'solargraph',
  'intelephense',
  'ruff', -- Fast Python linter and formatter
  'pyright',
  -- DON'T include pylsp - it conflicts with ruff for linting
}

lua_opts.capabilities = capabilities

require('mason').setup({})


require('mason-lspconfig').setup({
  ensure_installed = servers,
  handlers = {
    function(server_name)
      -- Skip pylsp to prevent conflicts with ruff
      if server_name == "pylsp" then
        return
      end
      lsp_zero.default_setup(server_name)
    end,

    lua_ls = function()
      -- Ensure Neovim runtime files are included
      lua_opts.settings = vim.tbl_deep_extend('force', lua_opts.settings or {}, {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          diagnostics = {
            globals = { 'vim' },
          },
        },
      })
      lspconfig.lua_ls.setup(lua_opts)
    end,

    hls = function()
      lspconfig.hls.setup {
        filetypes = { 'haskell', 'lhaskell', 'cabal' }
      }
    end,

    solargraph = function()
      lspconfig.solargraph.setup {
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

    -- Ruff for Python linting and formatting (fast!)
    ruff = function()
      lspconfig.ruff.setup {
        init_options = {
          settings = {
            -- Ruff language server settings
            lint = {
              enable = true,
              preview = true,
            },
            format = {
              enable = true,
              preview = true,
            },
            -- Run on every keystroke
            run = "onType",
            -- Auto-fix violations
            fixAll = true,
            -- Organize imports
            organizeImports = true,
          }
        },
        capabilities = capabilities,
        -- Make Ruff the default formatter for Python
        on_attach = function(client, bufnr)
          if client.name == "ruff" then
            -- Enable formatting for this client
            client.server_capabilities.documentFormattingProvider = true
            client.server_capabilities.documentRangeFormattingProvider = true
          end
        end,
      }
    end,

    -- Pyright for Python type checking (light mode)
    pyright = function()
      lspconfig.pyright.setup {
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              -- Use basic type checking instead of strict
              typeCheckingMode = "basic",
              -- Useful diagnostics to keep
              reportMissingImports = true,
              reportMissingModuleSource = false,
              -- Reduce noise from missing type stubs
              reportMissingTypeStubs = false,
              -- Let Ruff handle these
              reportUnusedVariable = false,
              reportUnusedImport = false,
              -- Light checking settings
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            }
          }
        },
        on_attach = function(client, bufnr)
          if client.name == "pyright" then
            -- Disable formatting - let Ruff handle it
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end
        end,
      }
    end,

    -- Add further server configurations here, if needed.
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
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
  },
  window = {
    completion = {
      winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
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
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping(function(fallback)
      fallback()
    end, { 'i', 's' }),
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
    ['<C-l>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.close()
      else
        fallback()
      end
    end, { 'i', 's' }),
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
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
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


-- Auto-fix on save (BufWritePost avoids recursive write)
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "oil" then return end
    vim.lsp.buf.code_action({
      context = {
        diagnostics = vim.diagnostic.get(0),
        only = { "source.fixAll" },
      },
      apply = true,
    })
    -- Auto-save the fixAll result after a short delay
    vim.defer_fn(function()
      if vim.bo.modified then
        vim.cmd('silent! write')
      end
    end, 500)
  end,
})
