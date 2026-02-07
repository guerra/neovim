# Nvim Config Audit — Changes Applied

**Date:** 2026-02-07
**Net result:** ~655 lines removed across 15 files (700 deleted, 45 added)

---

## Bug Fixes

### A1. BufWritePre recursive write + double formatting
**File:** `lua/user/lsp.lua`

- `BufWritePre` → `BufWritePost` — the old autocmd called `nvim_command('write')` inside a pre-write hook, causing recursive saves
- Removed the explicit ruff format block for Python — conform's `format_on_save` already handles it, so this was a duplicate pass
- `code_action({ only = "source.fixAll" })` is async — in BufWritePre it fired after the write completed, so fixAll never actually applied. Now runs post-write with a 500ms deferred save to persist the result

### A2. Dead `<leader>o` Oil bindings removed
**File:** `lua/user/vim.lua`

- Deleted the second `whichkey.add()` table that mapped `<leader>o`, `<leader>oo`, `<leader>of`, `<leader>oF` to Oil
- These were overwritten by Obsidian bindings in `remap.lua` anyway
- Oil is still accessible via `<leader>so` and `<leader>sO`

### A3. Deprecated diagnostic API
**File:** `lua/user/lsp.lua`

- `vim.lsp.diagnostic.get_line_diagnostics()` → `vim.diagnostic.get(0, { lnum = ... })`
- Old API removed since Neovim 0.10

### A4. Hardcoded Node.js path
**File:** `lua/guerra/plugins/alt-copilot.lua`

- `~/.asdf/installs/nodejs/22.15.1/bin/node` → `vim.fn.exepath('node')`
- No longer breaks when Node version changes

### A5. Orphaned copilot cmp source
**File:** `lua/user/lsp.lua`

- Removed `{ name = 'copilot' }` from cmp sources — copilot-cmp plugin is commented out, so this silently failed on every completion

### A6. Snacks terminal config nesting
**File:** `lua/guerra/plugins/snacks.lua`

- `bo`, `wo`, `keys` were inside an anonymous array `{ ... }` nested under `terminal` — snacks expects them as direct properties
- Flattened so terminal config actually applies (keybindings like `q` to hide, double-escape to normal mode)

---

## Dead Code Removed

### B1. Deleted avante.nvim + codecompanion.nvim (keeping gp.nvim)
- `lua/guerra/plugins/avante.lua` — deleted
- `lua/guerra/plugins/code-companion.lua` — deleted
- Their exclusive deps (render-markdown, img-clip, mcphub, mini.diff, mini.pick) will be cleaned by `:Lazy clean`

### B2. Old which-key.register() block
**File:** `lua/user/remap.lua` — removed 164 lines of commented-out old API migration artifact

### B3. Commented handler config
**File:** `lua/user/lsp.lua` — removed ~50 lines of old handler config and which-key block

### B4. Duplicate `<leader>ca`
**File:** `lua/user/lsp.lua` — removed `nvim_set_keymap` for `<leader>ca`, duplicated `<leader>vca` already on line 34

### B5. Empty plugin specs
- `lua/guerra/plugins/copilot.lua` — returned `{}`
- `lua/guerra/plugins/debugger.lua` — returned `{}`
- `lua/guerra/plugins/diffview.nvim.lua` — returned `{}`

### B6. Dead user modules + stale requires
- Deleted `lua/user/utils.lua`, `lua/user/rest.lua`, `lua/user/sg.lua`
- Cleaned commented `require('user.rest')` and `require('user.sg')` from `lua/user/init.lua`
- Cleaned commented `require('rest-nvim')` and `require('dapui')` from `lua/user/remap.lua`

### B7. One-liner commented alternatives
- `lua/user/lsp.lua` — removed commented winhighlight and formatting lines
- `lua/user/vim.lua` — removed commented colorscheme, colorcolumn, and highlight overrides

---

## Minor Improvements

### C1. `vim.loop` → `vim.uv`
**File:** `init.lua` — `vim.loop` deprecated since Neovim 0.10

---

## What to watch for / possible problems

1. **`:Lazy clean` is required** — run it to remove orphaned packages (avante, codecompanion, render-markdown, img-clip, mcphub, mini.diff, mini.pick, diffview, debugger). Without this they sit on disk unused.

2. **fixAll timing** — the new BufWritePost + 500ms defer approach means fixAll applies *after* the initial save, then saves again. If you notice a brief "file changed" flicker or double-write in the status line, that's the deferred save persisting the fixAll result. This is expected and harmless.

3. **fixAll on non-LSP filetypes** — the autocmd runs on `*` (all filetypes). For files with no LSP or no fixAll provider, `code_action()` is a no-op. If you see "No code actions available" messages on save for certain filetypes, the autocmd scope could be narrowed to specific filetypes.

4. **`<leader>ca` is gone** — only `<leader>vca` remains for code actions. If you had muscle memory for `<leader>ca`, remap it or adjust.

5. **Snacks terminal keybindings** — `q` to hide and double-escape to normal mode should now actually work since the config was flattened. If terminal behavior feels different, this is the fix taking effect.

6. **Copilot node resolution** — `vim.fn.exepath('node')` finds node from your PATH. If copilot breaks, check that `node` is in your shell PATH (run `:!which node` inside nvim to verify).

7. **gp.nvim is now the only AI plugin** — if you need avante or codecompanion features back, the files are recoverable from git history (`git checkout HEAD~1 -- lua/guerra/plugins/avante.lua`).
