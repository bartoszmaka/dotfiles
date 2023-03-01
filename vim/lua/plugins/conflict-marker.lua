return {
  'rhysd/conflict-marker.vim',
  config = function()
    vim.cmd [[
      let g:conflict_marker_enable_mappings = 0
    ]]
  end,
}

-- default
-- highlight ConflictMarkerBegin guibg=#2f7366
-- highlight ConflictMarkerOurs guibg=#2e5049
-- highlight ConflictMarkerTheirs guibg=#344f69
-- highlight ConflictMarkerEnd guibg=#525200
-- highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81
