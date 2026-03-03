return {
  'AndrewRadev/sideways.vim',
  keys = {
    { 'g9', ':SidewaysJumpLeft<CR>', desc = "Jump to left arg"},
    { 'g0', ':SidewaysJumpRight<CR>', desc = "Jump to right arg"},
    { 'g(', ':SidewaysLeft<CR>', desc = "Move arg to left"},
    { 'g)', ':SidewaysRight<CR>', desc = "Move arg to right"},
  },
}
