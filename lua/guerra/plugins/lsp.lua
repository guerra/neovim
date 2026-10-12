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
      -- Servers are enabled explicitly via vim.lsp.enable below
      automatic_enable = false,
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
    -- lua_ls runtime/`vim` global come from lazydev
    vim.lsp.config('lua_ls', {
      settings = { Lua = { workspace = { checkThirdParty = false } } },
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

    -- Pass blink.cmp completion capabilities to all LSP servers
    vim.lsp.config('*', {
      capabilities = require('blink.cmp').get_lsp_capabilities(),
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

        -- Formatting is owned by conform (formatters_by_ft); .env files get
        -- filetype 'dotenv', which no server handles

        -- Per-server capability overrides
        if client then
          if client.name == 'htmx' then
            client.server_capabilities.completionProvider = nil
          end

          -- Strip expensive capabilities for large files (>1MB)
          local fname = vim.api.nvim_buf_get_name(bufnr)
          if fname ~= '' and vim.fn.getfsize(fname) > 1000000 then
            client.server_capabilities.semanticTokensProvider = nil
            client.server_capabilities.inlayHintProvider = nil
          end

          -- Prefer LSP folding over the treesitter/indent folds set in treesitter.lua
          if client:supports_method('textDocument/foldingRange') then
            for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
              vim.wo[win][0].foldmethod = 'expr'
              vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
            end
          end
        end

        wk.add({
          buffer = bufnr,
          { 'gd', vim.lsp.buf.definition, desc = 'Go to definition' },
          { '<leader>i', vim.lsp.buf.hover, desc = 'Show hover' },
          { '<leader>vws', vim.lsp.buf.workspace_symbol, desc = 'Workspace symbols' },
          { '<leader>vd', vim.diagnostic.open_float, desc = 'Open diagnostics' },
          { '<leader>vj', function() vim.diagnostic.jump({ count = 1, float = true }) end, desc = 'Go to next diagnostic' },
          { '<leader>vk', function() vim.diagnostic.jump({ count = -1, float = true }) end, desc = 'Go to previous diagnostic' },
          { '<leader>vca', vim.lsp.buf.code_action, desc = 'Code action' },
          { '<leader>vrr', vim.lsp.buf.references, desc = 'References' },
          {
            '<leader>vrn',
            function()
              return ':IncRename ' .. vim.fn.expand('<cword>')
            end,
            expr = true,
            desc = 'Rename',
          },
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
    vim.diagnostic.config({
      virtual_text = {
        prefix = '● ',
        spacing = 4,
        format = function(diagnostic)
          local msg = diagnostic.message
          if #msg > 50 then
            return msg:sub(1, 50) .. '…'
          end
          return msg
        end,
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
          local code = diagnostic.code and (' [%s]'):format(diagnostic.code) or ''
          return ('%s%s'):format(diagnostic.message, code)
        end,
      },
      update_in_insert = false,
      severity_sort = true,
    })

    -- Auto-fix on save: apply source.fixAll synchronously before the write, so the
    -- fix lands in the same save (no second :write). Registered before conform's
    -- BufWritePre, so formatting runs after the fixes.
    -- ponytail: only workspace edits are applied; command-only actions would run async
    -- after the write, add exec_cmd + re-save if a server ever needs it
    vim.api.nvim_create_autocmd('BufWritePre', {
      callback = function(ev)
        local clients = vim.lsp.get_clients({ bufnr = ev.buf, method = 'textDocument/codeAction' })
        for _, client in ipairs(clients) do
          local params = {
            textDocument = vim.lsp.util.make_text_document_params(ev.buf),
            range = {
              start = { line = 0, character = 0 },
              ['end'] = { line = vim.api.nvim_buf_line_count(ev.buf), character = 0 },
            },
            context = { only = { 'source.fixAll' }, diagnostics = {} },
          }
          local res = client:request_sync('textDocument/codeAction', params, 1000, ev.buf)
          for _, action in ipairs(res and res.result or {}) do
            if (action.kind or ''):find('^source%.fixAll') then
              if not action.edit and client:supports_method('codeAction/resolve') then
                local resolved = client:request_sync('codeAction/resolve', action, 1000, ev.buf)
                action = resolved and resolved.result or action
              end
              if action.edit then
                vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
              end
            end
          end
        end
      end,
    })
  end,
}
