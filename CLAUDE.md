# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration for a polyglot developer (JS/TS, Python, Ruby, Go, Elixir, Lua, Haskell, PHP). Targets Neovim 0.12+. Uses lazy.nvim as the plugin manager (vim.pack is deliberately not used: it has no lazy-loading).

## Architecture

### One-File-Per-Plugin Pattern

Every plugin lives in its own file under `lua/guerra/plugins/`. Each file returns a lazy.nvim spec table that self-contains the plugin declaration, dependencies, config function, and keybindings.

```
init.lua                        → Bootstrap: sets leader to Space, lazy.nvim setup
lua/config/init.lua             → Pure vim settings + base keymaps (no plugin deps except which-key)
lua/guerra/plugins/*.lua        → One file per plugin
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
  { 'nvim-treesitter/nvim-treesitter', branch = 'main', config = function() ... end },
  { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
}
```

### Keymap Registration

**All keybindings use `which-key.add()`** — no scattered `vim.keymap.set()` calls. This is the unified keybinding API for the entire config.

Don't shadow Neovim's default mappings (`:h default-mappings`): `K` (hover), `gr*` (LSP), `[d`/`]d` (diagnostics), `[q`/`]q`, `<C-x>`, etc. Avoid `[`/`]` mappings (awkward on the user's keyboard). Treesitter moves use `<C-j>` (next) / `<C-k>` (prev) + `m`/`M`/`c`/`l`/`s`/`z`/`d`.

Leader key hierarchy:
- `<leader>g` — Telescope (find, grep, refs, branches)
- `<leader>v` — LSP actions (diagnostics, code action, rename)
- `<leader>x` — Trouble (diagnostics panel)
- `<leader>c` — Git (hunks, blame, import)
- `<leader>s` — Splits/editor/filesystem
- `<leader>o` — Obsidian
- `<leader>m` — Harpoon
- `<leader>n` — Toggles (snacks.toggle, Minuet auto-trigger)
- `<leader>9` — 99 AI
- `<leader>f` — Format (conform)
- `<C-g>` — AI terminals (claudecode; `<C-g>o` opencode)

### Core Plugin Roles

- **LSP**: `lsp.lua` — native `vim.lsp.config()`/`vim.lsp.enable()`; nvim-lspconfig only supplies server definitions; mason installs (`automatic_enable = false`, the explicit `vim.lsp.enable` list is the source of truth)
- **Completion**: `blink-cmp.lua`
- **Treesitter**: `treesitter.lua` — `main` branch (needs `tree-sitter` CLI); highlight via `vim.treesitter.start()` in a FileType autocmd, missing parsers installed on demand
- **Folds**: native. Treesitter `foldexpr` per window (indent fallback), upgraded to `vim.lsp.foldexpr()` on LspAttach; `zk` peek lives in `lua/config/init.lua`
- **Formatting**: `conform.lua` — prettier, stylua, mix, shfmt, gofumpt, ruff, etc.
- **Navigation**: `telescope.lua` (central; don't replace) + `harpoon.lua` + `oil.lua` + `aerial.lua`
- **UI**: `snacks.lua` (indent, input, words, zen, terminal, toggles) + `noice.lua` (owns `vim.notify`)
- **Git**: `gitsigns.lua` + `fugitive.lua` + snacks lazygit
- **AI**: `claudecode.lua`, `opencode.lua`, `99.lua`, `minuet-ai.lua` (inline completion)
- **Markdown/Notes**: `render-markdown.lua`, `live-preview.lua` (browser preview), `obsidian.lua` (obsidian-nvim community fork)
- **Colorscheme**: `rose-pine.lua` (moon variant)

### LSP Auto-Fix on Save

`lsp.lua` sets up a `BufWritePre` autocmd that synchronously requests `source.fixAll` code actions from each attached client and applies their workspace edits, so fixes land in the same write. It is registered before conform's `BufWritePre`, so formatting runs after. No-op when no LSP is attached.

## Code Style

- **Formatter**: StyLua (`.stylua.toml`): 2-space indent, single quotes
- **Lua LSP**: `.luarc.json` recognizes `vim` global and Neovim runtime
- Match existing patterns: 2-space indentation, single-quoted strings, no trailing semicolons
- Plugin filenames use the package name with dashes: `blink-cmp.lua`, `comment.nvim.lua`, `minuet-ai.lua`

## Key Conventions

- Keybindings always go inside the plugin's own file via `require('which-key').add()`
- `lua/config/init.lua` only contains vim options and plugin-free keymaps (clipboard, move lines, splits)
- Colorschemes use `lazy = false, priority = 1000` to load immediately
- Most plugins lazy-load via `event = "VeryLazy"` or `keys = { ... }`
- Helpers/utilities are defined locally within the plugin file that uses them (no shared utility module)
