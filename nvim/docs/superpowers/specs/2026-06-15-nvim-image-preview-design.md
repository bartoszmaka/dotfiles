# Image preview in Neovim — Design

Date: 2026-06-15

## Goal

Add image preview support to the Neovim config for two use cases:

1. **Opening image files** — opening `foo.png`/`.jpg`/etc. renders the picture in
   the buffer instead of showing binary garbage.
2. **Inline markdown images** — image links in markdown render as actual images
   while editing.

## Environment (all dependencies already satisfied)

- Terminal: **kitty** (native kitty graphics protocol), driven inside **tmux 3.6b**.
- tmux already has `set -g allow-passthrough on` and `set -g focus-events on`.
- nvim 0.12.2, lazy.nvim, treesitter present.
- `magick` (ImageMagick CLI), `ueberzugpp` (fallback backend) installed.
- No new system packages or luarocks required.

## Chosen tool: `3rd/image.nvim`

Picked over `snacks.nvim`'s image module because:

- Every dependency is already present (kitty, `magick` CLI, ueberzug fallback,
  treesitter) — zero new installs.
- The historical friction (the `magick` luarock) is gone: `magick_cli` is now the
  default processor and uses the installed ImageMagick CLI directly.
- First-class tmux support, which matters because tmux is the daily driver.
  snacks has open bug reports for markdown image links rendering as empty floats
  specifically under tmux.
- Single focused plugin rather than adopting the whole snacks framework (not
  currently used in this config).

kitty graphics gives full visual quality; ueberzug remains as automatic insurance.
No quality degradation is actually required.

## Architecture

- **New file:** `nvim/lua/plugins/image.lua` — one flat lazy.nvim spec table,
  matching the existing convention (e.g. `colorizer.lua`).
- No edits to other plugin files. `image.nvim` coexists with
  `render-markdown.nvim`: render-markdown styles text, image.nvim draws pixels.

## Plugin configuration

- `backend = "kitty"`, `processor = "magick_cli"` (both defaults; satisfied).
- **Image files:**
  `hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }`
  → opening one renders it in-buffer. Always on.
- **Markdown integration** enabled with:
  - `only_render_image_at_cursor = true`
  - `only_render_image_at_cursor_mode = "popup"`
    → image pops up only when the cursor is on the link; text layout stays put.
  - `resolve_image_path` for relative paths.
  - `download_remote_images = true` for `http(s)` links (cURL present).
- `tmux_show_only_in_active_window = true` → images don't bleed across tmux
  windows/panes.
- `max_width_window_percentage = 80`, `max_height_window_percentage = 80` → large
  images stay within the window.

## Loading

Lazy-load so startup is untouched, while still loading early enough for
`hijack_file_patterns` to fire on the first image-file open. The exact trigger
(`event = "VeryLazy"` vs. `ft`/pattern) will be confirmed empirically during
implementation, since hijack must be set up before the buffer loads. Markdown
loading via `ft = { "markdown", "codecompanion" }` mirrors the existing
`render-markdown` / `peek` specs.

## Keybind

- `<leader>mi` → toggle image rendering on/off, using
  `require("image").is_enabled()` / `enable()` / `disable()`.
- Grouped with the existing `<leader>mp` (markdown preview) keybind, registered
  with a which-key `desc` like the others.

## tmux

No required change — `allow-passthrough` and `focus-events` already on.
Optional, not applied unless requested: `set -g visual-activity off`.

## Dependencies to install

None.

## Verification (manual, in real kitty)

Image rendering cannot be asserted headlessly, so verification is manual:

1. Open a `.png` file → confirm the image renders in-buffer.
2. Open a markdown file with an image link, move cursor onto the link →
   confirm the popup image appears; move off → confirm it clears.
3. Press `<leader>mi` → confirm rendering toggles off, then on again.
4. Switch tmux windows → confirm no leftover/ghost images.

## Risks / open points

- Requires a real kitty graphics environment; nothing renders in a plain
  terminal or some tmux edge cases.
- `hijack_file_patterns` load-timing is the single empirical unknown — confirmed
  during implementation by actually opening an image file.
