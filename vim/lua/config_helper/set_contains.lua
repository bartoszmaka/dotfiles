local M = {}

M.set_contains = function (set, val)
  for key, value in pairs(set) do
    if value == val then return true end
  end
  return false
end

return M
