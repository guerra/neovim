# Neovim Config Reference

## 1. Keybinding Quick-Reference

Leader key: `<Space>`

### Core Editor (`<leader>s`, clipboard, movement)

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<leader>s` | n | **group: Editor / Filesystem** | config/init.lua |
| `<leader>sv` | n | Split window vertically | config/init.lua |
| `<leader>ss` | n | Split window horizontally | config/init.lua |
| `<leader>se` | n | Make splits equal size | config/init.lua |
| `<leader>sc` | n | Close current split | config/init.lua |
| `<leader>sr` | n | Show registers (which-key) | config/init.lua |
| `<leader>sm` | n | Jump to mark (which-key) | config/init.lua |
| `<leader>so` | n | Open oil (cwd) | oil.lua |
| `<leader>sO` | n | Open oil in current file folder | oil.lua |
| `<leader>st` | n | Toggle terminal (snacks) | snacks.lua |
| `<leader>sn` | n | New terminal (snacks) | snacks.lua |
| `<leader>sg` | n | Maximize/minimize split | vim-maximizer.lua |
| `<leader>sp` | v | Capture code snapshot | codesnap.lua |
| `<leader>sx` | n | Close buffer (preserve pane) | bdelete.lua |
| `<leader>sX` | n | Close all buffers | bdelete.lua |

### Clipboard & Registers

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<leader>p` | n | Paste preserving register | config/init.lua |
| `<leader>p` | v | Paste preserving register | config/init.lua |
| `<leader>y` | n, v | Yank to + register | config/init.lua |
| `<leader>Y` | n, v | Yank # lines to + register | config/init.lua |
| `<leader>P` | n | Paste from + register | config/init.lua |
| `<leader><S-d>` | n | Delete preserving register | config/init.lua |
| `<leader>d` | v | Delete preserving register | config/init.lua |
| `d` | v | Delete preserving register | config/init.lua |

### Line Movement & Misc

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<A-J>` | n | Move line down | config/init.lua |
| `<A-K>` | n | Move line up | config/init.lua |
| `<A-J>` | v | Move selected lines down | config/init.lua |
| `<A-K>` | v | Move selected lines up | config/init.lua |
| `<C-c>` | n | Clear search highlight | config/init.lua |

### Buffers

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<leader>j` | n | Previous buffer | bdelete.lua |
| `<leader>k` | n | Next buffer | bdelete.lua |
| `<leader>b` | n | List buffers (telescope) | telescope.lua |

### LSP (`<leader>v`, `gd`, `<leader>i`)

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<leader>v` | n | **group: Vim actions** | lsp-zero.lua |
| `gd` | n | Go to definition | lsp-zero.lua |
| `<leader>i` | n | Show hover | lsp-zero.lua |
| `<leader>vws` | n | Workspace symbols | lsp-zero.lua |
| `<leader>vd` | n | Open diagnostic float | lsp-zero.lua |
| `<leader>vj` | n | Next diagnostic | lsp-zero.lua |
| `<leader>vk` | n | Previous diagnostic | lsp-zero.lua |
| `<leader>vca` | n | Code action | lsp-zero.lua |
| `<leader>vrr` | n | References | lsp-zero.lua |
| `<leader>vrn` | n | Rename symbol | lsp-zero.lua |
| `<leader>vl` | n | Apply preferred code action (lint fix) | lsp-zero.lua |
| `<C-h>` | i | Signature help | lsp-zero.lua |

### Completion (nvim-cmp)

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<C-p>` | i, s | Previous item / jump snippet back | lsp-zero.lua |
| `<C-n>` | i, s | Next item / expand or jump snippet | lsp-zero.lua |
| `<C-y>` | i | Confirm selection | lsp-zero.lua |
| `<C-o>` | i | Trigger completion | lsp-zero.lua |
| `<C-i>` | i | Trigger completion | lsp-zero.lua |
| `<C-l>` | i, s | Close completion menu | lsp-zero.lua |
| `<C-d>` | i | Scroll docs up (-4) | lsp-zero.lua |
| `<C-f>` | i | Scroll docs down (+4) | lsp-zero.lua |
| `<Tab>` | i, s | Fallback (default tab behavior) | lsp-zero.lua |

### Minuet AI Completion (virtual text)

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<A-l>` | i | Accept suggestion | minuet-ai.lua |
| `<A-a>` | i | Accept line | minuet-ai.lua |
| `<C-]>` | i | Dismiss suggestion | minuet-ai.lua |
| `<A-[>` | i | Previous suggestion | minuet-ai.lua |
| `<A-]>` | i | Next suggestion | minuet-ai.lua |

### Telescope (`<leader>g`)

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<leader>g` | n | **group: Telescope** | telescope.lua |
| `<leader>gf` | n | Find files | telescope.lua |
| `<leader>gJ` | n | Git file search | telescope.lua |
| `<leader>gH` | n | Vim help tags | telescope.lua |
| `<leader>gg` | n | Live grep | telescope.lua |
| `<leader>gg` | v | Live grep selection | telescope.lua |
| `<leader>gG` | n | Grep current word | telescope.lua |
| `<leader>gq` | n | Aerial tags | telescope.lua |
| `<leader>gr` | n | LSP references | telescope.lua |
| `<leader>gR` | n | Aerial references | telescope.lua |
| `<leader>go` | n | Git worktrees | telescope.lua |
| `<leader>gc` | n | Create git worktree | telescope.lua |
| `<leader>gn` | n | Marks | telescope.lua |
| `<leader>gk` | n | Jumplist | telescope.lua |
| `<leader>gl` | n | Quickfix history | telescope.lua |
| `<leader>gL` | n | Registers | telescope.lua |
| `<leader>gh` | n | Harpoon list (telescope) | harpoon.lua |
| `<leader>gt` | n | Find tabs | telescope-tabs.lua |
| `<leader>gT` | n | Go to previous tab | telescope-tabs.lua |
| `<leader><space>` | n | Resume last picker | telescope.lua |

#### Telescope Git Sub-group (`<leader>gj`)

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<leader>gj` | n | **group: git** | telescope.lua |
| `<leader>gjs` | n | Git status | telescope.lua |
| `<leader>gjb` | n | Git branches | telescope.lua |
| `<leader>gjc` | n | Git commits | telescope.lua |
| `<leader>gjl` | n | Git buffer commits | telescope.lua |
| `<leader>gl` | v | Git buffer commits range | telescope.lua |

### Git (`<leader>c`)

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<leader>c` | n | **group: Coding / Repo** | gitsigns.lua |
| `<leader>cp` | n | Preview hunk | gitsigns.lua |
| `<leader>ct` | n | Preview hunk inline | gitsigns.lua |
| `<leader>cb` | n | Toggle line blame | gitsigns.lua |
| `<leader>cj` | n | Next hunk | gitsigns.lua |
| `<leader>ck` | n | Previous hunk | gitsigns.lua |
| `<leader>cd` | n | Diff this | gitsigns.lua |
| `<leader>cD` | n | Toggle deleted | gitsigns.lua |
| `<leader>cll` | n | Set location list | gitsigns.lua |
| `<leader>clf` | n | Set fix list | gitsigns.lua |
| `<leader>cg` | n | Open lazygit | snacks.lua |
| `<leader>ci` | n | Import / fixAll under cursor | lsp-zero.lua |

### Trouble (`<leader>x`)

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<leader>x` | n | **group: Trouble** | trouble.lua |
| `<leader>xx` | n | Toggle diagnostics | trouble.lua |
| `<leader>xd` | n | Document diagnostics | trouble.lua |
| `<leader>xw` | n | Workspace diagnostics | trouble.lua |
| `<leader>xs` | n | Symbols | trouble.lua |
| `<leader>xr` | n | LSP definitions / references | trouble.lua |
| `<leader>xq` | n | Quickfix list | trouble.lua |
| `<leader>xL` | n | Location list | trouble.lua |
| `<leader>xj` | n | Next diagnostic | trouble.lua |
| `<leader>xk` | n | Previous diagnostic | trouble.lua |
| `<leader>xh` | n | Previous in quickfix | trouble.lua |
| `<leader>xl` | n | Next in quickfix | trouble.lua |

### Testing (`<leader>t`)

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<leader>t` | n | **group: Testing** | neotest.lua |
| `<leader>tt` | n | Run closest test | neotest.lua |
| `<leader>tT` | n | Run tests on current file | neotest.lua |
| `<leader>tw` | n | Run Jest watch mode | neotest.lua |
| `<leader>ts` | n | Toggle test summary | neotest.lua |
| `<leader>to` | n | Show test output | neotest.lua |
| `<leader>tO` | n | Toggle test output panel | neotest.lua |
| `<leader>tc` | n | Clear test results | neotest.lua |
| `<leader>tl` | n | Jump to next failed test | neotest.lua |
| `<leader>th` | n | Jump to prev failed test | neotest.lua |

### Harpoon (`<leader>m`, `<C-e>`)

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<leader>m` | n | Add to harpoon list | harpoon.lua |
| `<leader>A` | n | Toggle quick menu | harpoon.lua |
| `<C-e>` | n | Toggle quick menu | harpoon.lua |
| `<leader>h` | n | Harpoon previous | harpoon.lua |
| `<leader>l` | n | Harpoon next | harpoon.lua |
| `<leader>1` | n | Go to tmux terminal 2 | harpoon.lua |
| `<leader>2` | n | Go to tmux terminal 3 | harpoon.lua |
| `<leader>3` | n | Go to tmux terminal 4 | harpoon.lua |
| `<leader>!` | v | Send selection to term 2 | harpoon.lua |
| `<leader>@` | v | Send selection to term 3 | harpoon.lua |
| `<leader>#` | v | Send selection to term 4 | harpoon.lua |

Harpoon menu internal keys (when quick menu is open):

| Key | Mode | Description |
|-----|------|-------------|
| `<C-v>` | n | Open in vsplit |
| `<C-x>` | n | Open in split |

### Aerial (`<leader>q`)

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<leader>q` | n | **group: Aerial tags** | aerial.lua |
| `<leader>q<space>` | n | Toggle aerial | aerial.lua |
| `<leader>qj` | n | Next tag | aerial.lua |
| `<leader>qk` | n | Prev tag | aerial.lua |

### Obsidian (`<leader>o`)

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<leader>o` | n | **group: Obsidian** | obsidian.lua |
| `<leader>oo` | n | Quick switch | obsidian.lua |
| `<leader>oc` | n | New note | obsidian.lua |
| `<leader>ot` | n | New from template | obsidian.lua |
| `<leader>od` | n | Dailies | obsidian.lua |
| `<leader>ob` | n | New note from buffer | obsidian.lua |

### Sessions (`<leader>w`)

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<leader>w` | n | **group: Session shortcuts** | auto-session.lua |
| `<leader>ww` | n | Save buffer (`:w`) | auto-session.lua |
| `<leader>wa` | n | Save all buffers (`:wa`) | auto-session.lua |
| `<leader>wq` | n | Quit all without saving | auto-session.lua |
| `<leader>wQ` | n | Force quit all | auto-session.lua |
| `<leader>wx` | n | Save all and quit | auto-session.lua |
| `<leader>wr` | n | Restore session for cwd | auto-session.lua |
| `<leader>ws` | n | Save session | auto-session.lua |

### Folding (`z`)

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `z` | n | **group: fold** | ufo.lua |
| `zR` | n | Open all folds | ufo.lua |
| `zM` | n | Close all folds | ufo.lua |
| `zk` | n | Peek fold (or hover) | ufo.lua |
| `zt` | n | Toggle line numbers + fold column | ufo.lua |

### Treesitter Motions & Text Objects

#### Text Object Selection (visual/operator-pending)

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `aF` | v, o | Select outer function | treesitter.lua |
| `iF` | v, o | Select inner function | treesitter.lua |
| `ac` | v, o | Select outer class | treesitter.lua |
| `ic` | v, o | Select inner class | treesitter.lua |
| `as` | v, o | Select scope (locals) | treesitter.lua |

#### Movement

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `Jm` | n | Next function start | treesitter.lua |
| `JM` | n | Next function end | treesitter.lua |
| `Jl` | n | Next loop | treesitter.lua |
| `Js` | n | Next scope | treesitter.lua |
| `Jz` | n | Next fold | treesitter.lua |
| `Jd` | n | Next conditional | treesitter.lua |
| `Km` | n | Previous function start | treesitter.lua |
| `KM` | n | Previous function end | treesitter.lua |
| `Kc` | n | Previous class start | treesitter.lua |
| `[d` | n | Previous conditional | treesitter.lua |

#### Peek Definition

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<leader>rf` | n | Peek function definition | treesitter.lua |
| `<leader>rF` | n | Peek class definition | treesitter.lua |

#### Repeatable Movement

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `;` | n, x, o | Repeat last move (next) | treesitter.lua |
| `,` | n, x, o | Repeat last move (prev) | treesitter.lua |
| `f` / `F` / `t` / `T` | n, x, o | Repeatable built-in motions | treesitter.lua |

### AI - gp.nvim (`<C-g>`)

#### Normal Mode

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<C-g>c` | n | New chat | gp.lua |
| `<C-g>t` | n | Toggle chat | gp.lua |
| `<C-g>f` | n | Chat finder | gp.lua |
| `<C-g>r` | n | Inline rewrite | gp.lua |
| `<C-g>a` | n | Append (after) | gp.lua |
| `<C-g>b` | n | Prepend (before) | gp.lua |
| `<C-g>n` | n | Next agent | gp.lua |
| `<C-g>s` | n | Stop | gp.lua |
| `<C-g>x` | n | Toggle context | gp.lua |
| `<C-g><C-t>` | n | New chat (tabnew) | gp.lua |
| `<C-g><C-v>` | n | New chat (vsplit) | gp.lua |
| `<C-g><C-x>` | n | New chat (split) | gp.lua |
| `<C-g>g` | n | **group: generate into new..** | gp.lua |
| `<C-g>ge` | n | GpEnew | gp.lua |
| `<C-g>gn` | n | GpNew | gp.lua |
| `<C-g>gp` | n | Popup | gp.lua |
| `<C-g>gt` | n | GpTabnew | gp.lua |
| `<C-g>gv` | n | GpVnew | gp.lua |
| `<C-g>w` | n | **group: Whisper** | gp.lua |
| `<C-g>ww` | n | Whisper | gp.lua |
| `<C-g>wa` | n | Whisper Append | gp.lua |
| `<C-g>wb` | n | Whisper Prepend | gp.lua |
| `<C-g>wr` | n | Whisper Inline Rewrite | gp.lua |
| `<C-g>we` | n | Whisper Enew | gp.lua |
| `<C-g>wn` | n | Whisper New | gp.lua |
| `<C-g>wp` | n | Whisper Popup | gp.lua |
| `<C-g>wt` | n | Whisper Tabnew | gp.lua |
| `<C-g>wv` | n | Whisper Vnew | gp.lua |

#### Visual Mode

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<C-g>c` | v | Visual Chat New | gp.lua |
| `<C-g>t` | v | Visual Toggle Chat | gp.lua |
| `<C-g>r` | v | Visual Rewrite | gp.lua |
| `<C-g>a` | v | Visual Append | gp.lua |
| `<C-g>b` | v | Visual Prepend | gp.lua |
| `<C-g>i` | v | Implement selection | gp.lua |
| `<C-g>p` | v | Visual Chat Paste | gp.lua |
| `<C-g>n` | v | Next Agent | gp.lua |
| `<C-g>s` | v | Stop | gp.lua |
| `<C-g>x` | v | Visual Context | gp.lua |
| `<C-g><C-t>` | v | ChatNew tabnew | gp.lua |
| `<C-g><C-v>` | v | ChatNew vsplit | gp.lua |
| `<C-g><C-x>` | v | ChatNew split | gp.lua |
| `<C-g>g*` | v | Generate into new (same as normal) | gp.lua |
| `<C-g>w*` | v | Whisper (same as normal) | gp.lua |

#### Insert Mode

All `<C-g>` mappings from normal mode are also available in insert mode.

### AI - Minuet & 99 (`<leader>9`)

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<leader>9` | n | **group: Minuet AI / 99** | minuet-ai.lua / 99.lua |
| `<leader>9t` | n | Toggle Minuet auto-trigger | minuet-ai.lua |
| `<leader>9n` | i | Trigger / next suggestion | minuet-ai.lua |
| `<leader>9p` | i | Trigger / prev suggestion | minuet-ai.lua |
| `<leader>9f` | n | Fill function (99) | 99.lua |
| `<leader>9v` | v | Visual AI (99) | 99.lua |
| `<leader>9s` | n | Stop request (99) | 99.lua |

### Mini Surround (`gs`)

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `gsa` | n, v | Add surrounding | mini-vim.lua |
| `gsd` | n | Delete surrounding | mini-vim.lua |
| `gsr` | n | Replace surrounding | mini-vim.lua |
| `gsf` | n | Find surrounding (right) | mini-vim.lua |
| `gsF` | n | Find surrounding (left) | mini-vim.lua |
| `gsh` | n | Highlight surrounding | mini-vim.lua |
| `gsn` | n | Update n lines | mini-vim.lua |

### File Explorers

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<leader><C-f>` | n | Neo-tree float toggle | neo-tree.lua |
| `<leader>T` | n | Neo-tree left toggle | neo-tree.lua |
| `<leader>so` | n | Oil (cwd) | oil.lua |
| `<leader>sO` | n | Oil (current file dir) | oil.lua |

### Tmux Navigation

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<A-h>` | n | Navigate left | tmux-navigation.lua |
| `<A-j>` | n | Navigate down | tmux-navigation.lua |
| `<A-k>` | n | Navigate up | tmux-navigation.lua |
| `<A-l>` | n | Navigate right | tmux-navigation.lua |
| `<A-\>` | n | Navigate last active | tmux-navigation.lua |
| `<A-Space>` | n | Navigate next | tmux-navigation.lua |

### Marks

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<leader>L` | n | Next mark | marks.nvim.lua |
| `<leader>H` | n | Previous mark | marks.nvim.lua |

### Misc Standalone

| Key | Mode | Description | Source |
|-----|------|-------------|--------|
| `<leader>u` | n | Toggle undotree | undotree.lua |
| `<leader>f` | n | Format buffer (conform) | conform.lua |
| `<leader>;` | n | Toggle minimap | mini-vim.lua |

---

## 2. Plugins Catalog

| Plugin | Role | Lazy-load | File |
|--------|------|-----------|------|
| lsp-zero.nvim | LSP core + mason + cmp | config | lsp-zero.lua |
| nvim-treesitter | Syntax highlighting + textobjects | `lazy=false` | treesitter.lua |
| nvim-treesitter-textobjects | TS motions & selections | dependency | treesitter.lua |
| treesitter playground | TS query inspector | lazy | treesitter.lua |
| telescope.nvim | Fuzzy finder | `keys` | telescope.lua |
| telescope-tabs | Tab picker | config | telescope-tabs.lua |
| harpoon (v2) | File/terminal bookmarks | config | harpoon.lua |
| harpoon-tmux | Tmux terminal integration | dependency | harpoon.lua |
| trouble.nvim | Diagnostics panel | `cmd`/`keys` | trouble.lua |
| conform.nvim | Formatter | `keys` | conform.lua |
| gitsigns.nvim | Git gutter signs | config | gitsigns.lua |
| vim-fugitive | Git commands | lazy | fugitive.lua |
| git-worktree.nvim | Worktree management | config | git-worktree.lua |
| neo-tree.nvim | File explorer (tree) | `VeryLazy` | neo-tree.lua |
| oil.nvim | File explorer (buffer) | config | oil.lua |
| gp.nvim | AI chat (OpenAI/Copilot) | config | gp.lua |
| minuet-ai.nvim | AI completion (Claude) | `InsertEnter` | minuet-ai.lua |
| 99 | AI function fill | `VeryLazy` | 99.lua |
| neotest | Test runner | config | neotest.lua |
| neotest-jest | Jest adapter | dependency | neotest.lua |
| neotest-rspec | RSpec adapter | dependency | neotest.lua |
| aerial.nvim | Code outline / tags | `keys` | aerial.lua |
| auto-session | Session management | config | auto-session.lua |
| nvim-ufo | Folding | config | ufo.lua |
| mini.nvim | AI textobjects + surround + minimap | config | mini-vim.lua |
| Comment.nvim | Commenting (gc) | config | comment.nvim.lua |
| nvim-ts-context-commentstring | Context-aware comments | dependency | comment.nvim.lua |
| bufdelete.nvim | Buffer delete (preserve layout) | `init` | bdelete.lua |
| undotree | Undo history | `keys` | undotree.lua |
| vim-maximizer | Split maximizer | `keys` | vim-maximizer.lua |
| codesnap.nvim | Code screenshots | config | codesnap.lua |
| marks.nvim | Enhanced marks | config | marks.nvim.lua |
| easypick.nvim | Custom telescope pickers | config | easypick.lua |
| snacks.nvim | Lazygit + terminal + scroll + bigfile | `lazy=false` | snacks.lua |
| nvim-tmux-navigation | Tmux/neovim split nav | config | tmux-navigation.lua |
| LuaSnip | Snippet engine | dependency | lua-snip.lua |
| friendly-snippets | Snippet collection | dependency | lua-snip.lua |
| dressing.nvim | UI input/select | config | dressing.lua |
| indent-blankline | Indent guides | `BufReadPre`/`BufNewFile` | indent-blankline.lua |
| lualine.nvim | Statusline | config | lualine.lua |
| noice.nvim | UI for cmdline/messages/popups | `VeryLazy` | noice.lua |
| nvim-notify | Notification manager | config | nvim-notify.lua |
| which-key.nvim | Keybinding hints | config | which-key.lua |
| markdown-preview.nvim | Markdown preview in browser | `cmd`/`ft` | markdown-preview.lua |
| markmap.nvim | Mindmap from markdown | `cmd` | markmap.nvim.lua |
| rose-pine | Colorscheme (active) | `lazy=false` | rose-pine.lua |
| kanagawa | Colorscheme (available) | lazy | kanagawa.lua |
| papercolor | Colorscheme (available) | lazy | papercolor.lua |
| transparent.nvim | Transparent backgrounds | `lazy=false` | transparent.lua |
| neodev.nvim | Neovim Lua API types | priority 1000 | neodev.lua |
| trim.nvim | Trailing whitespace trimmer | config | trim.lua |
| vim-ledger | Ledger filetype support | lazy | vim-ledger.lua |
| witt-neovim | Typing practice | config | witt-neovim.lua |

---

## 3. LSP Servers

| Server | Languages | Notable Settings |
|--------|-----------|------------------|
| `ts_ls` | TypeScript, JavaScript | default |
| `eslint` | JS/TS linting | default |
| `lua_ls` | Lua | Recognizes `vim` global, Neovim runtime |
| `gopls` | Go | default |
| `html` | HTML | default |
| `htmx` | HTMX | default |
| `bashls` | Bash/Shell | default |
| `templ` | Go Templ | default |
| `elixirls` | Elixir | default |
| `solargraph` | Ruby | `useBundler=true`, socket transport |
| `intelephense` | PHP | default |
| `ruff` | Python (linting/format) | lint+format preview, fixAll, organizeImports |
| `pyright` | Python (types) | basic type checking, formatting disabled |
| `hls` | Haskell | filetypes: haskell, lhaskell, cabal |

---

## 4. Formatters (conform.nvim)

| Filetype | Formatter |
|----------|-----------|
| javascript | prettier |
| typescript | prettier |
| javascriptreact | prettier |
| typescriptreact | prettier |
| css | prettier |
| html | prettier |
| json | prettier |
| yaml | prettier |
| markdown | prettier |
| graphql | prettier |
| lua | stylua |
| elixir | mix |
| shell / bash / sh | shfmt |
| haskell | fourmolu |
| go | gofumpt, goimports |
| ruby | rubyfmt |
| templ | templ |
| python | ruff |

---

## 5. Treesitter Parsers

18 installed parsers:

`bash`, `elixir`, `javascript`, `typescript`, `ruby`, `c`, `lua`, `vim`, `vimdoc`, `query`, `json`, `http`, `markdown`, `yaml`, `markdown_inline`, `ledger`, `python`

(Plus `auto_install = true` for any opened filetype.)

---

## 6. Completion Sources (nvim-cmp)

Priority order (top = highest):

1. `path` - File paths
2. `nvim_lsp` - LSP completions
3. `nvim_lsp_signature_help` - Function signatures
4. `nvim_lua` - Neovim Lua API
5. `luasnip` - Snippet completions

**AI virtual text** (minuet-ai): Triggered automatically on all filetypes with debounce (2s) and throttle (2.5s) to avoid firing on every keystroke. Accept with `<A-l>`, accept line with `<A-a>`, cycle with `<A-[>`/`<A-]>`.

---

## 7. Auto-Behaviors

| Behavior | Trigger | Source |
|----------|---------|--------|
| Format on save | `BufWritePre` (conform) | conform.lua |
| Auto-fix on save | `BufWritePost` (source.fixAll code action + deferred re-save) | lsp-zero.lua |
| Trim trailing whitespace | On save | trim.lua |
| Session auto-save | On exit (suppressed in ~, ~/downloads, ~/documents) | auto-session.lua |
| Minuet AI auto-trigger | Insert mode (all filetypes, 2s debounce / 2.5s throttle) | minuet-ai.lua |
| Bigfile detection | On open (snacks) | snacks.lua |
| Smooth scroll | Always (snacks) | snacks.lua |

---

## 8. Colorschemes

| Scheme | Status | Variant | File |
|--------|--------|---------|------|
| rose-pine-moon | **Active** | moon | rose-pine.lua |
| kanagawa | Available | - | kanagawa.lua |
| PaperColor | Available (commented out) | dark | papercolor.lua |

Transparency is enabled globally via `transparent.nvim`.

---

## 9. Commands & Pickers

### Custom Commands

| Command | Description | Source |
|---------|-------------|--------|
| `ObsidianNewFromBuffer` | Create Obsidian note from current buffer content | obsidian.lua |
| `MarkdownPreview` | Preview markdown in browser | markdown-preview.lua |
| `MarkdownPreviewToggle` | Toggle markdown preview | markdown-preview.lua |
| `MarkdownPreviewStop` | Stop markdown preview | markdown-preview.lua |
| `MarkmapOpen` | Open markmap visualization | markmap.nvim.lua |
| `MarkmapSave` | Save markmap | markmap.nvim.lua |
| `MarkmapWatch` | Watch markmap changes | markmap.nvim.lua |
| `MarkmapWatchStop` | Stop markmap watch | markmap.nvim.lua |
| `Minuet virtualtext toggle` | Toggle AI auto-trigger | minuet-ai.lua |

### Easypick Pickers

| Picker | Command | Description |
|--------|---------|-------------|
| `ls` | `ls` | List files in cwd |
| `changed_files` | `git diff --name-only` vs master | Files changed since branch from master |
| `conflicts` | `git diff --name-only --diff-filter=U` | Merge conflict files |
