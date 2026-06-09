# Per-tabpage scoped buffers (IDE-like editor groups)

**Date:** 2026-06-09
**Status:** Approved — ready for implementation plan

## Goal

Get a more IDE-like tab experience. Today barbar.nvim shows one global tabline
listing every open buffer, regardless of which split is focused. The desired
behavior is that each "editor group" has its own set of tabs, so the tabline is
no longer cluttered with files unrelated to what the focused area is working on.

## Constraint that shapes the design

Neovim buffers are global, and there is no robust plugin that gives true
VS Code-style "each side-by-side split owns its own independent tabs." Replicating
that would require custom per-window buffer bookkeeping rendered in `winbar` —
fragile, unmaintained, and high-maintenance.

We therefore use Neovim's native **tabpages** as the unit of isolation (the
"editor group"). `scope.nvim` saves and restores the buffer list per tabpage, and
barbar renders only the buffers belonging to the focused tabpage. Splits *within*
a tabpage still work normally and share that group's tabs.

This is the "hybrid" model: keep barbar exactly as the tabline, add scope.nvim so
the buffer list is scoped per tabpage.

## Approach

### Component 1 — `scope.nvim` plugin

New plugin spec file: `nvim/lua/plugins/scope.lua`.

- Plugin: `tiagovla/scope.nvim`
- Depends on `romgrk/barbar.nvim` (load ordering so the integration hooks fire
  against an initialized barbar).
- Configure scope.nvim with the **barbar-documented** integration hooks. These
  fire `User` autocmds that barbar listens to so buffer order and pins survive a
  group switch:

```lua
return {
  {
    'tiagovla/scope.nvim',
    dependencies = { 'romgrk/barbar.nvim' },
    config = function()
      require('scope').setup({
        hooks = {
          pre_tab_leave = function()
            vim.api.nvim_exec_autocmds('User', { pattern = 'ScopeTabLeavePre' })
          end,
          post_tab_enter = function()
            vim.api.nvim_exec_autocmds('User', { pattern = 'ScopeTabEnterPost' })
          end,
        },
      })
      -- group-management keymaps go here (Component 3)
    end,
  },
}
```

### Component 2 — barbar.nvim

No changes. `tabpages = true` is already set in `nvim/lua/plugins/barbar.lua`, so
the tabpage indicator already renders. The existing barbar buffer keymaps
(`<leader>{`, `<leader>}`, `<leader>1..9`, etc.) continue to operate on the
focused group's scoped buffer list.

### Component 3 — group-management keymaps

Added in `scope.lua`'s `config` using the repo's existing `require('helper').nnoremap`
helper (matches the convention in `barbar.lua`). Native commands work but are
clunky; these provide an ergonomic surface consistent with the existing
buffer-navigation maps (`<leader>{` / `<leader>}`).

| Key          | Action                          | Command          |
|--------------|---------------------------------|------------------|
| `<leader>tn` | New empty editor group          | `:tabnew`        |
| `<leader>tx` | Close current editor group      | `:tabclose`      |
| `<leader>[`  | Previous editor group           | `gT`             |
| `<leader>]`  | Next editor group               | `gt`             |
| `<leader>tm` | Move current buffer to a group  | `:ScopeMoveBuf`  |

Notes:
- `:ScopeMoveBuf <tab_nr>` is telescope-free; with no argument it prompts for the
  target tab number. `<leader>tm` maps to `:ScopeMoveBuf<CR>` so it prompts the
  user for the destination group.
- `<leader>t…` maps land under the existing which-key "Test / Toggle" group label;
  acceptable, no relabeling required.

## Conflict check

- No existing tabpage/`gt`/`:tabnew` keymaps in the config.
- `<leader>tt`, `<leader>tf` (test) and `<leader>tb`, `<leader>td` (gitsigns) are
  taken — the new `<leader>t` maps (`tn`, `tx`, `tm`) avoid those.
- `<leader>[` / `<leader>]` must be confirmed free during implementation before
  binding.

## Testing / verification

Manual, since this is editor config:

1. Open file A. `:tabnew`, open file B. Switch between groups with `<leader>[` /
   `<leader>]` and confirm barbar's tabline shows only the focused group's buffers.
2. Within one group, `:split` and confirm both splits share that group's tabs.
3. Pin a buffer and reorder buffers in group 1, switch to group 2 and back, and
   confirm order + pin survived (validates the integration hooks).
4. `<leader>tm` moves the current buffer out of the current group into another and
   confirm it disappears from the source tabline and appears in the target.
5. `<leader>tx` closes a group without orphaning the others.

## Out of scope

- True per-split (side-by-side) independent tabs via `winbar`.
- Session persistence of scope state (`:ScopeSaveState` / `:ScopeLoadState`) — can
  be added later if a session manager is in use.
