# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration for a polyglot developer (JS/TS, Python, Ruby, Go, Elixir, Lua, Haskell, PHP). Uses lazy.nvim as the plugin manager with ~46 plugins.

## Architecture

### One-File-Per-Plugin Pattern

Every plugin lives in its own file under `lua/guerra/plugins/`. Each file returns a lazy.nvim spec table that self-contains the plugin declaration, dependencies, config function, and keybindings.

```
init.lua                        → Bootstrap: sets leader to Space, lazy.nvim setup
lua/config/init.lua             → Pure vim settings + base keymaps (no plugin deps except which-key)
lua/guerra/plugins/*.lua        → One file per plugin (46 files)
```

`init.lua` loads plugins via `require('lazy').setup({ import = 'guerra.plugins' })`, which auto-discovers all files in the plugins directory. Then `require('config')` loads vim options and core keybindings.

### Plugin File Structure

Single spec:
```lua
return {
  'author/plugin-name',
  dependencies = { ... },
  event = "VeryLazy",  -- or keys = { ... } for lazy-loading
  config = function()
    -- setup
    require('which-key').add({ ... })  -- keybindings at the end
  end,
}
```

Multiple specs (e.g., treesitter ecosystem):
```lua
return {
  { 'nvim-treesitter/nvim-treesitter', config = function() ... end },
  { 'nvim-treesitter/playground' },
}
```

### Keymap Registration

**All keybindings use `which-key.add()`** — no scattered `vim.keymap.set()` calls. This is the unified keybinding API for the entire config.

Leader key hierarchy:
- `<leader>g` — Telescope (find, grep, refs, branches)
- `<leader>v` — LSP actions (diagnostics, code action, rename)
- `<leader>x` — Trouble (diagnostics panel)
- `<leader>c` — Git (hunks, blame, import)
- `<leader>s` — Splits/editor/filesystem
- `<leader>o` — Obsidian
- `<leader>m` — Harpoon
- `<leader>f` — Format (conform)
- `<C-g>` — gp.nvim AI assistant

### Core Plugin Roles

- **LSP**: `lsp-zero.lua` (358 lines) — mason, lspconfig, nvim-cmp, diagnostics, 15 language servers
- **Formatting**: `conform.lua` — prettier, stylua, mix, shfmt, gofumpt, ruff, etc.
- **Navigation**: `telescope.lua` + `harpoon.lua` + `neo-tree.lua` + `oil.lua`
- **Git**: `gitsigns.lua` + `fugitive.lua` + `git-worktree.lua`
- **AI**: `gp.lua` (OpenAI/Copilot) + `alt-copilot.lua` (GitHub Copilot)
- **Colorscheme**: `rose-pine.lua` (active, moon variant), kanagawa and papercolor available

### LSP Auto-Fix on Save

`lsp-zero.lua` sets up a `BufWritePost` autocmd that triggers `source.fixAll` code actions, followed by a deferred re-save. This runs on all buffers (no-op when no LSP is attached).

## Code Style

- **Formatter**: StyLua (`.stylua.toml`): 2-space indent, single quotes
- **Lua LSP**: `.luarc.json` recognizes `vim` global and Neovim runtime
- Match existing patterns: 2-space indentation, single-quoted strings, no trailing semicolons
- Plugin filenames use the package name with dashes: `lsp-zero.lua`, `comment.nvim.lua`, `gp.lua`

## Key Conventions

- Keybindings always go inside the plugin's own file via `require('which-key').add()`
- `lua/config/init.lua` only contains vim options and plugin-free keymaps (clipboard, move lines, splits)
- Colorschemes use `lazy = false, priority = 1000` to load immediately
- Most plugins lazy-load via `event = "VeryLazy"` or `keys = { ... }`
- Helpers/utilities are defined locally within the plugin file that uses them (no shared utility module)
