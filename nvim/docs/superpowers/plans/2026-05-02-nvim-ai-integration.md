# Neovim AI Integration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add AI chat (avante.nvim with Claude Pro/Max OAuth + Codex via ACP / ChatGPT subscription) and AI completions (GitHub Copilot via blink.cmp source) to the existing Neovim config, with a right-side chat window, provider/model switch keymaps, and a small statusline indicator.

**Architecture:** Two new lazy.nvim plugin spec files (`ai_chat.lua`, `ai_complete.lua`), one heirline component extension, one `blink.cmp` sources extension, one which-key label change. Subscription auth only — no API keys. avante owns the chat sidebar (right, ~40% width); copilot.lua provides the LSP that `blink-copilot` translates into a `blink.cmp` source so suggestions appear in the existing completion menu instead of as competing ghost-text.

**Tech Stack:** Neovim ≥ 0.11, lazy.nvim, avante.nvim, copilot.lua, blink.cmp, blink-copilot, heirline.nvim, which-key.nvim, codex CLI (brew), Claude OAuth (`auth_type = "max"`).

**Verification model:** Neovim plugin work has no automated test runner. Each task ends with explicit manual verification steps in a fresh `nvim` invocation. Steps that can be automated (file existence, byte content, lazy-lock changes) are scripted.

---

## File Plan

| Path | Action | Responsibility |
|---|---|---|
| `nvim/lua/plugins/ai_old.lua` | DELETE | obsolete commented-out experiment |
| `nvim/lua/plugins/ai_chat.lua` | CREATE | avante.nvim plugin spec, providers, window, keymaps |
| `nvim/lua/plugins/ai_complete.lua` | CREATE | copilot.lua + blink-copilot plugin specs |
| `nvim/lua/plugins/autocomplete.lua` | MODIFY | add `copilot` to `blink.cmp` sources |
| `nvim/lua/plugins/which-key.lua` | MODIFY | rename `<leader>A` group label to `AI` |
| `nvim/lua/helper/heirline_components.lua` | MODIFY | add avante provider/model component |

All file paths below are relative to repo root `~/.repos/dotfiles`.

---

## Task 1: Remove obsolete `ai_old.lua`

**Files:**
- Delete: `nvim/lua/plugins/ai_old.lua`

- [ ] **Step 1: Delete the file**

```bash
git -C ~/.repos/dotfiles rm nvim/lua/plugins/ai_old.lua
```

- [ ] **Step 2: Verify nvim still loads cleanly (headless)**

```bash
nvim --headless "+lua print('OK')" "+qa" 2>&1 | tail -20
```

Expected: prints `OK`, no `E5113` / `E492` errors. lazy.nvim may print plugin install messages — that's fine.

- [ ] **Step 3: Commit**

```bash
git -C ~/.repos/dotfiles commit -m "Remove obsolete ai_old.lua"
```

---

## Task 2: Create `ai_chat.lua` with avante spec (chat opens, no keymaps yet)

**Files:**
- Create: `nvim/lua/plugins/ai_chat.lua`

- [ ] **Step 1: Write the plugin spec file**

Create `nvim/lua/plugins/ai_chat.lua` with the following exact content:

```lua
return {
  {
    'yetone/avante.nvim',
    build = vim.fn.has('win32') ~= 0
      and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
      or 'make',
    version = false,
    cmd = {
      'AvanteAsk',
      'AvanteChat',
      'AvanteToggle',
      'AvanteEdit',
      'AvanteRefresh',
      'AvanteSwitchProvider',
      'AvanteModels',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'stevearc/dressing.nvim',
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.icons',
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = { file_types = { 'markdown', 'Avante' } },
        ft = { 'markdown', 'Avante' },
      },
    },
    opts = {
      provider = 'claude',
      providers = {
        claude = {
          endpoint = 'https://api.anthropic.com',
          model = 'claude-sonnet-4-6',
          auth_type = 'max',
          timeout = 30000,
          extra_request_body = { temperature = 0.2 },
        },
      },
      acp_providers = {
        codex = {
          command = 'npx',
          args = { '-y', '@zed-industries/codex-acp' },
          env = {
            NODE_NO_WARNINGS = '1',
            -- Intentionally NO OPENAI_API_KEY: forces ChatGPT subscription auth
            -- via ~/.codex/auth.json populated by `codex login`.
          },
        },
      },
      windows = {
        position = 'right',
        width = 40,
        sidebar_header = { enabled = true, align = 'center', rounded = false },
      },
    },
  },
}
```

- [ ] **Step 2: Trigger lazy install**

```bash
nvim --headless "+Lazy! sync" "+qa" 2>&1 | tail -30
```

Expected: avante and its dependencies appear as `+` (added) in lazy output; `make` build runs. If `make` fails (no Rust/C toolchain), avante still installs but logs a warning — acceptable for v1, fallback tokenizer is used.

- [ ] **Step 3: Manual verification — chat opens on the right**

In a fresh interactive nvim:

```
:AvanteToggle
```

Expected: a chat sidebar opens **on the right side** of the editor. If `auth_type = "max"` triggers a browser tab, complete the OAuth flow once. Close nvim.

- [ ] **Step 4: Commit**

```bash
git -C ~/.repos/dotfiles add nvim/lua/plugins/ai_chat.lua nvim/lazy-lock.json
git -C ~/.repos/dotfiles commit -m "Add avante.nvim chat with Claude OAuth + Codex ACP"
```

---

## Task 3: Add chat keymaps to `ai_chat.lua`

**Files:**
- Modify: `nvim/lua/plugins/ai_chat.lua`

- [ ] **Step 1: Add a `keys` field to the avante spec**

Edit `nvim/lua/plugins/ai_chat.lua`. Insert the following `keys = { ... }` block immediately **before** the `dependencies = { ... }` line:

```lua
    keys = {
      { '<C-k><C-o>', '<cmd>AvanteToggle<cr>',         desc = 'AI: toggle chat',        mode = { 'n', 'v' } },
      { '<leader>Ac', '<cmd>AvanteToggle<cr>',         desc = 'AI: toggle chat',        mode = { 'n' } },
      { '<leader>Aa', '<cmd>AvanteAsk<cr>',            desc = 'AI: ask',                mode = { 'n', 'v' } },
      { '<leader>Ae', '<cmd>AvanteEdit<cr>',           desc = 'AI: edit selection',     mode = { 'v' } },
      { '<leader>Ar', '<cmd>AvanteRefresh<cr>',        desc = 'AI: refresh',            mode = { 'n' } },
      { '<leader>Ap', '<cmd>AvanteSwitchProvider<cr>', desc = 'AI: switch provider',    mode = { 'n' } },
      { '<leader>Am', '<cmd>AvanteModels<cr>',         desc = 'AI: switch model',       mode = { 'n' } },
      { '<leader>An', '<cmd>AvanteChat<cr>',           desc = 'AI: new chat',           mode = { 'n' } },
      { '<leader>Ah', '<cmd>AvanteHistory<cr>',        desc = 'AI: chat history',       mode = { 'n' } },
    },
```

- [ ] **Step 2: Verify the file parses**

```bash
nvim --headless "+lua dofile(vim.fn.stdpath('config') .. '/lua/plugins/ai_chat.lua')" "+qa" 2>&1 | tail -10
```

Expected: no Lua syntax errors. Empty / quiet output is success.

- [ ] **Step 3: Manual verification — chord opens chat**

In a fresh interactive nvim, open a normal buffer and press `<C-k><C-o>`. Expected: avante chat toggles open on the right.

- [ ] **Step 4: Commit**

```bash
git -C ~/.repos/dotfiles add nvim/lua/plugins/ai_chat.lua
git -C ~/.repos/dotfiles commit -m "Add avante chat keymaps under <leader>A and <C-k><C-o>"
```

---

## Task 4: Update which-key group label

**Files:**
- Modify: `nvim/lua/plugins/which-key.lua:19`

- [ ] **Step 1: Rename the `<leader>A` group label**

Open `nvim/lua/plugins/which-key.lua`. Change line 19 from:

```lua
      { '<leader>A', group = 'AI (CodeCompanion)' },
```

to:

```lua
      { '<leader>A', group = 'AI' },
```

- [ ] **Step 2: Manual verification — popup shows updated label**

In a fresh interactive nvim, press `<leader>A` and wait for the which-key popup. Expected: the popup heading reads `AI` (no parenthetical).

- [ ] **Step 3: Commit**

```bash
git -C ~/.repos/dotfiles add nvim/lua/plugins/which-key.lua
git -C ~/.repos/dotfiles commit -m "Rename <leader>A which-key group to AI"
```

---

## Task 5: End-to-end auth verification (no code change)

This is a verification-only task — no commits unless config tweaks are needed.

- [ ] **Step 1: Verify Claude OAuth chat round-trip**

In a fresh interactive nvim:

```
:AvanteAsk
```

In the prompt, type `say hello` and submit. Expected: a model response appears in the right sidebar within ~10s. If a browser opens for OAuth, complete it; subsequent invocations should not re-prompt.

- [ ] **Step 2: Switch to Codex provider**

```
:AvanteSwitchProvider codex
```

Expected: status line / chat header indicates the active provider is now `codex`. The first message will spawn `npx -y @zed-industries/codex-acp`, which will lazily download the shim on first use (visible delay of 5–30s).

- [ ] **Step 3: Verify Codex round-trip on subscription**

In the chat input, send `say hello`. Expected: a response from a GPT model. If it errors with "no auth", run `codex login` in a terminal and retry. If it errors complaining about `OPENAI_API_KEY`, verify the env block in `ai_chat.lua` is empty and re-launch nvim.

- [ ] **Step 4: Switch back and verify model picker**

```
:AvanteSwitchProvider claude
:AvanteModels
```

Expected: `:AvanteModels` opens a picker listing claude models. Select a different one (e.g. `claude-opus-4-7`); subsequent `:AvanteAsk` uses it. **If `claude-sonnet-4-6` was rejected by the API**, note the working alias from `:AvanteModels` and update the `model = '...'` line in `ai_chat.lua` (then commit that one-line change).

---

## Task 6: Create `ai_complete.lua` with Copilot + blink-copilot

**Files:**
- Create: `nvim/lua/plugins/ai_complete.lua`

- [ ] **Step 1: Write the plugin spec file**

Create `nvim/lua/plugins/ai_complete.lua` with:

```lua
return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        ['*'] = true,
        gitcommit = false,
        gitrebase = false,
        AvanteInput = false,
        ['copilot-chat'] = false,
        ['neo-tree'] = false,
        TelescopePrompt = false,
      },
    },
  },
  {
    'fang2hou/blink-copilot',
    lazy = true,
  },
}
```

- [ ] **Step 2: Trigger lazy install**

```bash
nvim --headless "+Lazy! sync" "+qa" 2>&1 | tail -20
```

Expected: `copilot.lua` and `blink-copilot` appear as `+` (added) in lazy output.

- [ ] **Step 3: Authenticate Copilot (one-time, manual)**

In a fresh interactive nvim:

```
:Copilot auth
```

Follow the device-flow prompt — it prints a code and a URL; open the URL in a browser, paste the code, authorize. Then back in nvim:

```
:Copilot status
```

Expected output includes `Online` and `Enabled`.

- [ ] **Step 4: Commit**

```bash
git -C ~/.repos/dotfiles add nvim/lua/plugins/ai_complete.lua nvim/lazy-lock.json
git -C ~/.repos/dotfiles commit -m "Add Copilot + blink-copilot plugins (ghost-text disabled)"
```

---

## Task 7: Wire Copilot into `blink.cmp` sources

**Files:**
- Modify: `nvim/lua/plugins/autocomplete.lua:60`

- [ ] **Step 1: Add `blink-copilot` as a dependency of `blink.cmp`**

Open `nvim/lua/plugins/autocomplete.lua`. In the `blink.cmp` spec (the first entry of the returned table), change the `dependencies` block from:

```lua
    dependencies = {
      'echasnovski/mini.icons',
    },
```

to:

```lua
    dependencies = {
      'echasnovski/mini.icons',
      'fang2hou/blink-copilot',
    },
```

- [ ] **Step 2: Add `copilot` to default sources and register the provider**

In the same file, replace the entire `sources = { ... }` block (currently lines ~59–72) with:

```lua
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
        providers = {
          lsp = {
            override = {
              get_trigger_characters = function(self)
                local trigger_characters = self:get_trigger_characters()
                vim.list_extend(trigger_characters, { '\n', '\t', ' ' })
                return trigger_characters
              end,
            },
          },
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
          },
        },
      },
```

- [ ] **Step 3: Verify the file parses**

```bash
nvim --headless "+lua dofile(vim.fn.stdpath('config') .. '/lua/plugins/autocomplete.lua')" "+qa" 2>&1 | tail -10
```

Expected: no Lua syntax errors.

- [ ] **Step 4: Manual verification — Copilot suggestions in blink menu**

In a fresh interactive nvim, open a `.lua` or `.py` file. Type a function header like `def fibonacci(n):` and press Enter. Wait ~1s in insert mode. Expected: `blink.cmp` menu opens and Copilot suggestions are visible (ranked at the top thanks to `score_offset = 100`), distinguishable by their kind icon. `<Tab>` / `<CR>` accepts as usual.

- [ ] **Step 5: Commit**

```bash
git -C ~/.repos/dotfiles add nvim/lua/plugins/autocomplete.lua
git -C ~/.repos/dotfiles commit -m "Add Copilot as blink.cmp source"
```

---

## Task 8: Add avante provider/model statusline component

**Files:**
- Modify: `nvim/lua/helper/heirline_components.lua` (insert before the LSP block in `M.statusline`, after the `%=` separator on line 438)

- [ ] **Step 1: Add an `avante_status` local component above `M.statusline`**

In `nvim/lua/helper/heirline_components.lua`, insert the following block immediately **before** the `M.statusline = {` declaration (currently at line 404):

```lua
local function avante_provider_label()
  local ok_cfg, cfg = pcall(require, 'avante.config')
  if not ok_cfg or type(cfg.get) ~= 'function' then
    return ''
  end
  local ok_get, settings = pcall(cfg.get)
  if not ok_get or type(settings) ~= 'table' then
    return ''
  end

  local provider = settings.provider
  if type(provider) ~= 'string' or provider == '' then
    return ''
  end

  local model = ''
  local providers = settings.providers
  if type(providers) == 'table' and type(providers[provider]) == 'table' then
    model = providers[provider].model or ''
  end
  if model == '' then
    local acp = settings.acp_providers
    if type(acp) == 'table' and type(acp[provider]) == 'table' then
      model = acp[provider].model or ''
    end
  end

  if model == '' then
    return string.format(' 󰚩 %s ', provider)
  end
  return string.format(' 󰚩 %s:%s ', provider, model)
end

local AvanteStatus = {
  condition = function()
    return package.loaded['avante.config'] ~= nil
  end,
  provider = function()
    return avante_provider_label()
  end,
  hl = { fg = colors.purple, bg = colors.bg_d },
  update = { 'BufEnter', 'WinEnter', 'User' },
}
```

- [ ] **Step 2: Insert `AvanteStatus` into the statusline**

In the same file, find the LSP block in `M.statusline` (currently around line 440 starting with `condition = conditions.lsp_attached,`). Insert `AvanteStatus,` as a sibling **immediately before** that LSP block. The structure should look like:

```lua
  { provider = "%=", hl = { bg = colors.bg_d } },
  AvanteStatus,
  {
    condition = conditions.lsp_attached,
    -- ... existing LSP block unchanged ...
  },
```

- [ ] **Step 3: Verify the file parses**

```bash
nvim --headless "+lua dofile(vim.fn.stdpath('config') .. '/lua/helper/heirline_components.lua')" "+qa" 2>&1 | tail -10
```

Expected: no Lua syntax errors.

- [ ] **Step 4: Manual verification — statusline shows provider:model**

Launch a fresh interactive nvim and open any file. Run `:AvanteToggle` once to load avante. Expected: the statusline shows ` 󰚩 claude:claude-sonnet-4-6 ` (or whatever model you set) on the right side, between the LSP names and diagnostics. Run `:AvanteSwitchProvider codex` and switch buffers (`:enew` then `:b#`) — the label updates to `codex`.

- [ ] **Step 5: Commit**

```bash
git -C ~/.repos/dotfiles add nvim/lua/helper/heirline_components.lua
git -C ~/.repos/dotfiles commit -m "Show active avante provider:model in statusline"
```

---

## Task 9: Smoke test full integration

This is a verification-only task — no commits unless a regression is found.

- [ ] **Step 1: Cold-start sanity**

```bash
nvim --headless "+lua print(vim.fn.has('nvim-0.11'))" "+Lazy! show" "+qa" 2>&1 | tail -40
```

Expected: prints `1` (Neovim ≥ 0.11). `:Lazy show` lists `avante.nvim`, `copilot.lua`, `blink-copilot`, `blink.cmp`, `heirline.nvim`, `which-key.nvim` — all loaded or ready.

- [ ] **Step 2: Interactive walkthrough**

Launch interactive nvim in a real project directory. Verify each:

1. `<C-k><C-o>` toggles right-side chat ✓
2. `<leader>Aa` opens an ask prompt ✓
3. `<leader>Ap` opens provider switch picker ✓
4. `<leader>Am` opens model picker ✓
5. `<leader>A` (held) shows the which-key popup labeled `AI` with all entries ✓
6. In insert mode in a code file, Copilot suggestions appear in the `blink.cmp` menu ✓
7. Statusline shows ` 󰚩 claude:... ` ✓
8. Pre-existing autocomplete sources (LSP, snippets, buffer) still work — `<Tab>` cycles, `<CR>` accepts ✓
9. `<leader>a` still triggers projectionist `:A` (alternate file) — confirm no clash ✓

- [ ] **Step 3: Regression-free confirmation**

If any step in 2 fails, that's the regression — fix in a follow-up task before declaring v1 done. If all pass, the implementation is complete.

---

## Out-of-scope reminders (do NOT add in this plan)

- Usage / quota display in statusline (deferred to v2)
- Custom prompts / slash commands beyond avante defaults
- MCP / tool-use integration via avante
- Per-project provider preference

## Known risks (already noted in the spec)

- `auth_type = "max"` requires a browser on first launch. SSH-only environments need to fall back to `auth_type = "api_key"` with `ANTHROPIC_API_KEY` — out of scope here.
- `claude-sonnet-4-6` model identifier is the current best guess; Task 5 step 4 covers updating it to whatever `:AvanteModels` reports as valid.
- `score_offset = 100` puts Copilot above LSP in the `blink.cmp` menu. If LSP feels drowned out during real use, lower to `50` in `autocomplete.lua` (one-line change).
- avante `make` build needs a working C toolchain (likely Xcode CLT on macOS). Without it, avante still loads with a slower fallback tokenizer.
