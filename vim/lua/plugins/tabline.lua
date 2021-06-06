local config_helper = require('config_helper')

local nnoremap = config_helper.nnoremap

vim.g.mapleader = ' '

vim.g.bufferline = {
  animation = true,
  auto_hide = false,
  tabpages = true,
  closable = false,
}

nnoremap('<leader>[', ':BufferPrevious<CR>')
nnoremap('<leader>]', ':BufferNext<CR>')
nnoremap('<leader>{', ':BufferMovePrevious<CR>')
nnoremap('<leader>}', ':BufferMoveNext<CR>')
nnoremap('<leader>1', ':BufferGoto 1<CR>')
nnoremap('<leader>2', ':BufferGoto 2<CR>')
nnoremap('<leader>3', ':BufferGoto 3<CR>')
nnoremap('<leader>4', ':BufferGoto 4<CR>')
nnoremap('<leader>5', ':BufferGoto 5<CR>')
nnoremap('<leader>6', ':BufferGoto 6<CR>')
nnoremap('<leader>7', ':BufferGoto 7<CR>')
nnoremap('<leader>8', ':BufferGoto 8<CR>')
nnoremap('<leader>9', ':BufferLast<CR>')
nnoremap('<leader>q', ':close<CR>')
nnoremap('<leader>w', ':BufferClose<CR>')
nnoremap('<leader><leader>!', ':BufferCloseAllButCurrent<CR>')

--let fg_target = 'red'

--let fg_current  = s:fg(['Normal'], '#efefef')
--let fg_visible  = s:fg(['TabLineSel'], '#efefef')
--let fg_inactive = s:fg(['TabLineFill'], '#888888')

--let fg_modified  = s:fg(['WarningMsg'], '#E5AB0E')
--let fg_special  = s:fg(['Special'], '#599eff')
--let fg_subtle  = s:fg(['NonText', 'Comment'], '#555555')

--let bg_current  = s:bg(['Normal'], '#000000')
--let bg_visible  = s:bg(['TabLineSel', 'Normal'], '#000000')
--let bg_inactive = s:bg(['TabLineFill', 'StatusLine'], '#000000')

---- Meaning of terms:
----
---- format: "Buffer" + status + part
----
---- status:
----     *Current: current buffer
----     *Visible: visible but not current buffer
----    *Inactive: invisible but not current buffer
----
---- part:
----        *Icon: filetype icon
----       *Index: buffer index
----         *Mod: when modified
----        *Sign: the separator between buffers
----      *Target: letter in buffer-picking mode
----
---- BufferTabpages: tabpage indicator
---- BufferTabpageFill: filler after the buffer section
---- BufferOffset: offset section, created with set_offset()

--call s:hi_all([
--\ ['BufferCurrent',        fg_current,  bg_current],
--\ ['BufferCurrentIndex',   fg_special,  bg_current],
--\ ['BufferCurrentMod',     fg_modified, bg_current],
--\ ['BufferCurrentSign',    fg_special,  bg_current],
--\ ['BufferCurrentTarget',  fg_target,   bg_current,   'bold'],
--\ ['BufferVisible',        fg_visible,  bg_visible],
--\ ['BufferVisibleIndex',   fg_visible,  bg_visible],
--\ ['BufferVisibleMod',     fg_modified, bg_visible],
--\ ['BufferVisibleSign',    fg_visible,  bg_visible],
--\ ['BufferVisibleTarget',  fg_target,   bg_visible,   'bold'],
--\ ['BufferInactive',       fg_inactive, bg_inactive],
--\ ['BufferInactiveIndex',  fg_subtle,   bg_inactive],
--\ ['BufferInactiveMod',    fg_modified, bg_inactive],
--\ ['BufferInactiveSign',   fg_subtle,   bg_inactive],
--\ ['BufferInactiveTarget', fg_target,   bg_inactive,  'bold'],
--\ ['BufferTabpages',       fg_special,  bg_inactive, 'bold'],
--\ ['BufferTabpageFill',    fg_inactive, bg_inactive],
--\ ])

--call s:hi_link([
--\ ['BufferCurrentIcon',  'BufferCurrent'],
--\ ['BufferVisibleIcon',  'BufferVisible'],
--\ ['BufferInactiveIcon', 'BufferInactive'],
--\ ['BufferOffset',       'BufferTabpageFill'],
--\ ])

---- NOTE: this is an example taken from the source, implementation of
---- s:fg(), s:bg(), s:hi_all() and s:hi_link() is left as an exercise
---- for the reader.
-- https://github.com/romgrk/barbar.nvim/blob/master/autoload/bufferline/highlight.vim
