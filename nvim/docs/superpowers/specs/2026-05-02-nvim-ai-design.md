# Neovim AI Integration — Design (v1)

Date: 2026-05-02
Status: approved, ready for implementation plan

## Goal

Add AI chat and AI completions to the existing Neovim configuration, using the user's existing **subscription** auth (no API keys), with a right-side chat window, the ability to switch providers and models from inside Neovim, and minimal disruption to current keymaps and UI.

## Decisions

| Topic | Decision |
|---|---|
| Chat plugin | `yetone/avante.nvim` |
| Chat providers | Claude (native, OAuth via `auth_type = "max"`) and Codex (ACP via `@zed-industries/codex-acp`, ChatGPT subscription via `codex login`) |
| Default provider on startup | `claude` |
| Chat window position | right side, ~40% of editor width |
| Completion engine | GitHub Copilot via `zbirenbaum/copilot.lua` + `fang2hou/blink-copilot` source for `blink.cmp` |
| Ghost-text from Copilot | disabled — suggestions appear inside the existing `blink.cmp` menu |
| Model picker | two keybindings: provider switch (`<leader>Ap`) + model switch within provider (`<leader>Am`) |
| Keymap prefix | `<leader>A*` (capital, because lowercase `<leader>a` is taken by projectionist's alternate-file) |
| Chat toggle chord | `<C-k><C-o>` (matches user's prior muscle memory) |
| Statusline | minimal v1 component showing current avante provider:model when avante is loaded |
| Usage / quota display | **deferred to v2** |

## Components

```
lua/plugins/
  ai_chat.lua        ← NEW: avante.nvim spec
  ai_complete.lua    ← NEW: copilot.lua + blink-copilot bridge
  autocomplete.lua   ← MODIFIED: add 'copilot' source to blink.cmp
  which-key.lua      ← MODIFIED: register <leader>A group label "AI"
  ai_old.lua         ← DELETED
lua/helper/
  heirline_components.lua  ← MODIFIED: add small avante provider/model component
docs/superpowers/specs/
  2026-05-02-nvim-ai-design.md  ← this file
```

Lazy.nvim auto-discovers plugin files under `lua/plugins/`, so no changes to `setup_lazy.lua`.

### `ai_chat.lua` (avante.nvim)

- **Lazy triggers:** `cmd = { "AvanteAsk", "AvanteChat", "AvanteToggle", "AvanteSwitchProvider", "AvanteModels" }` plus the `<C-k><C-o>` chord and the `<leader>A*` keymaps.
- **Build:** `make` (compiles avante's tokenizer extension; if the build step fails, plugin still loads with a degraded experience — acceptable).
- **Dependencies:** `nvim-lua/plenary.nvim`, `MunifTanjim/nui.nvim`, `stevearc/dressing.nvim`, `nvim-treesitter/nvim-treesitter`, `echasnovski/mini.icons`.

**Provider config (sketch):**

```lua
provider = "claude",
providers = {
  claude = {
    endpoint = "https://api.anthropic.com",
    model = "claude-sonnet-4-7",
    auth_type = "max",                       -- Claude Pro/Max OAuth
    timeout = 30000,
    extra_request_body = { temperature = 0.2 },
  },
},
acp_providers = {
  codex = {
    command = "npx",
    args = { "-y", "@zed-industries/codex-acp" },
    env = {
      NODE_NO_WARNINGS = "1",
      -- Intentionally no OPENAI_API_KEY: forces ChatGPT subscription auth via ~/.codex/auth.json
    },
  },
},
windows = {
  position = "right",
  width = 40,
},
```

**Keymaps:**

| Key | Mode | Action |
|---|---|---|
| `<C-k><C-o>` | n, v | `:AvanteToggle` |
| `<leader>Aa` | n, v | `:AvanteAsk` |
| `<leader>Ac` | n | `:AvanteToggle` |
| `<leader>Ae` | v | `:AvanteEdit` |
| `<leader>Ar` | n | `:AvanteRefresh` |
| `<leader>Ap` | n | `:AvanteSwitchProvider` (Claude ↔ Codex) |
| `<leader>Am` | n | `:AvanteModels` (model picker within provider) |
| `<leader>An` | n | New chat |
| `<leader>Ah` | n | Chat history |

### `ai_complete.lua` (Copilot)

```lua
{
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  opts = {
    suggestion = { enabled = false },     -- ghost-text off; we use blink menu instead
    panel      = { enabled = false },
    filetypes = {
      ["*"] = true,
      gitcommit = false,
      gitrebase = false,
      AvanteInput = false,
      ["copilot-chat"] = false,
    },
  },
},
{
  "fang2hou/blink-copilot",
  lazy = true,
},
```

**One-time setup:** user runs `:Copilot auth` after install (browser device-flow login to GitHub).

### `autocomplete.lua` extension

Add Copilot to `blink.cmp` sources:

```lua
sources = {
  default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
  providers = {
    copilot = {
      name = 'copilot',
      module = 'blink-copilot',
      score_offset = 100,
      async = true,
    },
    lsp = { ... },  -- unchanged
  },
},
```

### Statusline (heirline) component

Reads avante's current provider and model. Renders only when avante module is loaded; otherwise empty (zero cost). Updates on `User AvanteProviderChanged` and `User AvanteModelChanged` autocmds emitted by avante. Inserted to the right of the LSP block, before filetype.

Display format: `󰚩 claude:sonnet-4-7` — icon is a static glyph (Nerd Font `nf-md-robot`, codepoint U+F06A9), provider/model strings come from `require("avante.config").get().provider` and the resolved model in the active provider config. No icon-pack dependency.

### Which-key

Register the `<leader>A` group with label "AI" so the popup shows it grouped.

## External dependencies (one-time, user-side)

| Tool | Install | Auth |
|---|---|---|
| `node` / `npx` | already present (used by avante build + codex-acp shim) | — |
| `codex` CLI | `brew install codex` (already done) | `codex login` (already done) |
| Claude OAuth | — | `:AvanteAuth` triggers browser flow on first chat |
| GitHub Copilot | installed by lazy.nvim | `:Copilot auth` after install |

## Out of scope (v2)

- Usage / quota display in statusline (Claude OAuth doesn't expose quota cheaply; would need `ccusage` integration or polling `~/.claude/projects/`)
- Codex subscription quota display
- Custom prompts / slash commands beyond avante defaults
- MCP / tool-use integration via avante
- Configurable per-project provider preference

## Risks

1. **`auth_type = "max"` requires browser** — first launch opens a browser tab. Headless / SSH sessions need a fallback to `auth_type = "api_key"` with `ANTHROPIC_API_KEY`. Document this in the file's comment header.
2. **`codex-acp` is a Zed-published npm package** that wraps a brew-installed CLI. If Zed renames or stops publishing it, we'd need a replacement adapter. Mitigated by avante's pluggable `acp_providers`.
3. **Copilot above LSP via `score_offset = 100`** — if real LSP completions get drowned out, tune the offset down (e.g. `50`) or move Copilot below LSP.
4. **`make` build step for avante** requires a working C/Rust toolchain. Without it, avante still loads but uses a slower fallback tokenizer.

## Implementation order (for the plan)

1. Delete `ai_old.lua`.
2. Add `ai_chat.lua` with avante and the keymaps; verify `<C-k><C-o>` toggles a right-side chat.
3. Verify `auth_type = "max"` browser flow works; verify `:AvanteSwitchProvider` flips to codex and chat hits the brew-installed CLI.
4. Add `ai_complete.lua`, run `:Copilot auth`, confirm Copilot reports `Enabled`.
5. Extend `autocomplete.lua` with the `copilot` source; verify suggestions appear in the `blink.cmp` menu.
6. Add the heirline statusline component; confirm it shows `claude:sonnet-4-7` and updates on provider/model switch.
7. Register the `<leader>A` group in which-key.
8. Smoke test: chat both providers, switch model mid-chat, accept a Copilot suggestion via `<CR>` / `<Tab>`.
