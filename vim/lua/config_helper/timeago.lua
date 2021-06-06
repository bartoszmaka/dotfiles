local M = {}

local text =  {
  justnow = 'just now',
  minute = {singular = 'a minute ago', plural = 'minutes ago'},
  hour = {singular = 'an hour ago', plural = 'hours ago'},
  day = {singular = 'a day ago', plural = 'days ago'},
  week = {singular = 'a week ago', plural = 'weeks ago'},
  month = {singular = 'a month ago', plural = 'months ago'},
  year = {singular = 'a year ago', plural = 'years ago'}
}

---@type table
---@param num number
---@return number
local function round(num) return math.floor(num + 0.5) end

---@param time osdate
---@return string
function M.format(time)
  local now = os.time()
  local diff_seconds = os.difftime(now, time)
  if diff_seconds < 45 then return text.justnow end

  local diff_minutes = diff_seconds / 60
  if diff_minutes < 1.5 then return text.minute.singular end
  if diff_minutes < 59.5 then
    return round(diff_minutes) .. ' ' .. text.minute.plural
  end

  local diff_hours = diff_minutes / 60
  if diff_hours < 1.5 then return text.hour.singular end
  if diff_hours < 23.5 then
    return round(diff_hours) .. ' ' .. text.hour.plural
  end

  local diff_days = diff_hours / 24
  if diff_days < 1.5 then return text.day.singular end
  if diff_days < 7.5 then
    return round(diff_days) .. ' ' .. text.day.plural
  end

  local diff_weeks = diff_days / 7
  if diff_weeks < 1.5 then return text.week.singular end
  if diff_weeks < 4.5 then
    return round(diff_weeks) .. ' ' .. text.week.plural
  end

  local diff_months = diff_days / 30
  if diff_months < 1.5 then return text.month.singular end
  if diff_months < 11.5 then
    return round(diff_months) .. ' ' .. text.month.plural
  end

  local diff_years = diff_days / 365.25
  if diff_years < 1.5 then return text.year.singular end
  return round(diff_years) .. ' ' .. text.year.plural

end

return M
