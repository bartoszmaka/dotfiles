local M = {}

M.set_contains = function (set, val)
  for _, value in ipairs(set) do
    if value == val then
      return true
    end
  end

  return false
end

return M
