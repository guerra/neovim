return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'saghen/blink.cmp',
  },
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local wk = require('which-key')

    -- Mason: install servers
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = {
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
        'ruff',
        'pyright',
      },
    })

    -- Server-specific overrides (merged with lspconfig defaults)
    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          workspace = { checkThirdParty = false },
          diagnostics = { globals = { 'vim' } },
        },
      },
    })

    vim.lsp.config('solargraph', {
      settings = {
        solargraph = {
          autoformat = false,
          bundlerPath = 'bundle',
          checkGemVersion = true,
          commandPath = 'solargraph',
          completion = true,
          definitions = true,
          diagnostics = true,
          folding = true,
          formatting = false,
          hover = true,
          logLevel = 'warn',
          references = true,
          rename = true,
          symbols = true,
          transport = 'socket',
          useBundler = true,
        },
      },
    })

    vim.lsp.config('ruff', {
      init_options = {
        settings = {
          lint = { enable = true, preview = true },
          format = { enable = true, preview = true },
          run = 'onType',
          fixAll = true,
          organizeImports = true,
        },
      },
    })

    vim.lsp.config('pyright', {
      settings = {
        python = {
          analysis = {
            typeCheckingMode = 'basic',
            reportMissingImports = true,
            reportMissingModuleSource = false,
            reportMissingTypeStubs = false,
            reportUnusedVariable = false,
            reportUnusedImport = false,
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = 'workspace',
          },
        },
      },
    })

    vim.lsp.config('hls', {
      filetypes = { 'haskell', 'lhaskell', 'cabal' },
    })

    -- Enable all servers
    vim.lsp.enable({
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
      'ruff',
      'pyright',
      'hls',
    })

    -- which-key groups
    wk.add({
      { '<leader>v', group = 'Vim actions' },
      { '<leader>vr', group = 'Review' },
    })

    -- Buffer-local keybindings on attach
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local bufnr = ev.buf

        -- Exclude .env files
        if vim.fn.expand('%'):find('^%.env') then
          if client then client:stop() end
          return
        end

        -- Per-server capability overrides
        if client then
          if client.name == 'ruff' then
            client.server_capabilities.documentFormattingProvider = true
            client.server_capabilities.documentRangeFormattingProvider = true
          end
          if client.name == 'pyright' then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end
          if client.name == 'ts_ls' or client.name == 'eslint' then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end

          -- Strip expensive capabilities for large files (>1MB)
          local fname = vim.api.nvim_buf_get_name(bufnr)
          if fname ~= '' and vim.fn.getfsize(fname) > 1000000 then
            client.server_capabilities.semanticTokensProvider = nil
            client.server_capabilities.inlayHintProvider = nil
          end
        end

        wk.add({
          buffer = bufnr,
          { 'gd', vim.lsp.buf.definition, desc = 'Go to definition' },
          { '<leader>i', vim.lsp.buf.hover, desc = 'Show hover' },
          { '<leader>vws', vim.lsp.buf.workspace_symbol, desc = 'Workspace symbols' },
          { '<leader>vd', vim.diagnostic.open_float, desc = 'Open diagnostics' },
          { '<leader>vj', vim.diagnostic.goto_next, desc = 'Go to next diagnostic' },
          { '<leader>vk', vim.diagnostic.goto_prev, desc = 'Go to previous diagnostic' },
          { '<leader>vca', vim.lsp.buf.code_action, desc = 'Code action' },
          { '<leader>vrr', vim.lsp.buf.references, desc = 'References' },
          { '<leader>vrn', vim.lsp.buf.rename, desc = 'Rename' },
          {
            '<C-h>',
            vim.lsp.buf.signature_help,
            mode = 'i',
            desc = 'Signature help',
          },
          {
            '<leader>vl',
            function()
              vim.lsp.buf.code_action({
                filter = function(a) return a.isPreferred end,
                apply = true,
              })
            end,
            desc = 'Call lint fix',
          },
          {
            '<leader>ci',
            function()
              vim.lsp.buf.code_action({
                context = {
                  diagnostics = vim.diagnostic.get(
                    0,
                    { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 }
                  ),
                  only = { 'source.fixAll' },
                },
                apply = true,
              })
            end,
            desc = 'Import module under cursor',
          },
        })
      end,
    })

    -- Diagnostics config
    local function format_message(message, max_width)
      local formatted_message = {}
      while #message > max_width do
        local part = message:sub(1, max_width)
        local next_part = message:sub(max_width + 1)
        table.insert(formatted_message, part)
        message = next_part
      end
      table.insert(formatted_message, message)
      return table.concat(formatted_message, '\n')
    end

    vim.diagnostic.config({
      virtual_text = {
        prefix = '● ',
        spacing = 4,
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = ' ',
          [vim.diagnostic.severity.WARN] = ' ',
          [vim.diagnostic.severity.HINT] = ' ',
          [vim.diagnostic.severity.INFO] = ' ',
        },
      },
      underline = true,
      float = {
        border = 'rounded',
        source = 'if_many',
        focusable = false,
        format = function(diagnostic)
          return format_message(diagnostic.message, 80)
        end,
      },
      update_in_insert = false,
      severity_sort = true,
    })

    -- Auto-fix on save (BufWritePost avoids recursive write)
    vim.api.nvim_create_autocmd('BufWritePost', {
      pattern = '*',
      callback = function()
        if vim.bo.filetype == 'oil' then return end
        vim.lsp.buf.code_action({
          context = {
            diagnostics = vim.diagnostic.get(0),
            only = { 'source.fixAll' },
          },
          apply = true,
        })
        vim.defer_fn(function()
          if vim.bo.modified then
            vim.cmd('silent! write')
          end
        end, 500)
      end,
    })
  end,
}
