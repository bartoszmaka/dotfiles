local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt

local function split_path(path)
  local parts = {}
  for part in string.gmatch(path, "[^/]+") do
    table.insert(parts, part)
  end
  return parts
end

local function to_pascal_case(value)
  local words = {}
  for part in string.gmatch(value, "[^_]+") do
    table.insert(words, part:sub(1, 1):upper() .. part:sub(2))
  end
  return table.concat(words, "")
end

local function class_from_path()
  local relative_path = vim.fn.expand("%:.")
  local filename = split_path(relative_path)
  filename = filename[#filename] or "class_name"
  local stem = filename:gsub("%..+$", "")
  stem = stem:gsub("_spec$", "")
  return stem
end

local function modules_from_path()
  local relative_path = vim.fn.expand("%:.")
  local parts = split_path(relative_path)
  local modules = {}

  for idx = 3, #parts - 1 do
    table.insert(modules, parts[idx])
  end

  return modules
end

local function short_class_with_modules()
  local parts = {}
  for _, part in ipairs(modules_from_path()) do
    table.insert(parts, to_pascal_case(part))
  end
  table.insert(parts, to_pascal_case(class_from_path()))
  if #parts == 0 then
    return "described_class"
  end
  return table.concat(parts, "::")
end

local function constructor_variables(raw)
  local variables = {}
  local seen = {}

  for chunk in string.gmatch(raw or "", "[^,]+") do
    local cleaned = vim.trim(chunk)
    local name = cleaned:match("^([%a_][%w_]*)%s*:") or cleaned:match("^([%a_][%w_]*)")
    if name and not seen[name] then
      seen[name] = true
      table.insert(variables, name)
    end
  end

  return variables
end

local function constructor_assignments(args)
  local variables = constructor_variables(args[1][1])
  if #variables == 0 then
    return "  "
  end

  local lines = {}
  for _, name in ipairs(variables) do
    table.insert(lines, "  @" .. name .. " = " .. name)
  end
  return lines
end

local function constructor_attr_reader(args)
  local variables = constructor_variables(args[1][1])
  if #variables == 0 then
    return ""
  end

  local readers = {}
  for _, name in ipairs(variables) do
    table.insert(readers, ":" .. name)
  end

  return "private\n\nattr_reader " .. table.concat(readers, ", ")
end

local function class_scaffold()
  local modules = modules_from_path()
  local indent = ""
  local nodes = {}

  for _, module_name in ipairs(modules) do
    table.insert(nodes, t(indent .. "module " .. to_pascal_case(module_name)))
    indent = indent .. "  "
    table.insert(nodes, t({ "", indent }))
  end

  table.insert(nodes, t(indent .. "class "))
  table.insert(nodes, i(1, to_pascal_case(class_from_path())))
  table.insert(nodes, t({ "", indent .. "  " }))
  table.insert(nodes, i(0))
  table.insert(nodes, t({ "", indent .. "end" }))

  for _ = #modules, 1, -1 do
    indent = indent:sub(1, -3)
    table.insert(nodes, t({ "", indent .. "end" }))
  end

  return sn(nil, nodes)
end

return {
  s("cla", d(1, class_scaffold, {})),
  s(
    "defi",
    fmt(
      [[
def initialize({})
{}
end

{}
{}
]],
      {
        i(1, "args"),
        f(constructor_assignments, { 1 }),
        f(constructor_attr_reader, { 1 }),
        i(0),
      }
    )
  ),
  s(
    "spec",
    fmt(
      [[
require 'rails_helper'

RSpec.describe {} do
  {}
end
]],
      {
        f(short_class_with_modules),
        i(0),
      }
    )
  ),
}
