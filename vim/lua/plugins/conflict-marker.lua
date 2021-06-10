vim.cmd[[
let g:conflict_marker_enable_mappings = 0
  augroup conflict_marker_config
  autocmd!

  highlight! ConflictMarkerBegin  guibg=#525200
  highlight! ConflictMarkerOurs  guibg=#525200
  highlight! ConflictMarkerTheirs  guibg=#283c34
  highlight! ConflictMarkerEnd  guibg=#283c34
  highlight! ConflictMarkerCommonAncestorsHunk  guibg=#382c34

  augroup END
]]
