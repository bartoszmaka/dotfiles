return {
  'rhysd/conflict-marker.vim',
  config = function()
    vim.cmd [[
      let g:conflict_marker_enable_mappings = 0

      augroup conflict_marker_overrides
        autocmd!
        highlight! ConflictMarkerBegin  guibg=#283c34
        highlight! ConflictMarkerOurs  guibg=#1a2e1b
        highlight! ConflictMarkerTheirs  guibg=#2a324a
        highlight! ConflictMarkerEnd  guibg=#2f628e
        highlight! ConflictMarkerCommonAncestorsHunk  guibg=#382c34
      augroup END
    ]]
  end,
}

-- default
-- highlight ConflictMarkerBegin guibg=#2f7366
-- highlight ConflictMarkerOurs guibg=#2e5049
-- highlight ConflictMarkerTheirs guibg=#344f69
-- highlight ConflictMarkerEnd guibg=#525200
-- highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81
