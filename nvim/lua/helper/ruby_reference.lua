local M = {}

local declaration_types = {
  assignment = true,
  class = true,
  method = true,
  module = true,
  operator_assignment = true,
  singleton_method = true,
}

local namespace_types = {
  class = true,
  module = true,
}

local function node_text(node, bufnr)
  if not node then
    return nil
  end

  return vim.treesitter.get_node_text(node, bufnr)
end

local function declaration_for_name(node)
  local current = node
  while current do
    if declaration_types[current:type()] then
      local name = current:field('name')[1] or current:field('left')[1]
      if name and (current:type() == 'assignment' or current:type() == 'operator_assignment') then
        local name_type = name:type()
        if name_type ~= 'constant' and name_type ~= 'scope_resolution' then
          name = nil
        end
      end
      if name and (node == name or vim.treesitter.is_ancestor(name, node)) then
        return current
      end
    end
    current = current:parent()
  end
end

local function namespace_for(declaration, bufnr)
  local parts = {}
  local current = declaration

  while current do
    if namespace_types[current:type()] then
      local name = node_text(current:field('name')[1], bufnr)
      if name then
        table.insert(parts, 1, name)
        if vim.startswith(name, '::') then
          break
        end
      end
    end
    current = current:parent()
  end

  return table.concat(parts, '::'):gsub('::::', '::')
end

local function is_class_method(declaration)
  if declaration:type() == 'singleton_method' then
    return true
  end

  local current = declaration:parent()
  while current do
    if current:type() == 'singleton_class' then
      return true
    end
    if namespace_types[current:type()] then
      return false
    end
    current = current:parent()
  end

  return false
end

function M.reference_at_cursor(bufnr, row, col)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  row = row or vim.api.nvim_win_get_cursor(0)[1] - 1
  col = col or vim.api.nvim_win_get_cursor(0)[2]

  local ok, parser = pcall(vim.treesitter.get_parser, bufnr, 'ruby')
  if not ok then
    return nil, 'Ruby Tree-sitter parser is not available'
  end

  local tree = parser:parse()[1]
  local node = tree:root():named_descendant_for_range(row, col, row, col)
  local declaration = declaration_for_name(node)
  if not declaration then
    return nil, 'Cursor is not on a Ruby class, module, method, or constant definition'
  end

  if namespace_types[declaration:type()] then
    return namespace_for(declaration, bufnr)
  end

  if declaration:type() == 'assignment' or declaration:type() == 'operator_assignment' then
    local name = node_text(declaration:field('left')[1], bufnr)
    local namespace = namespace_for(declaration:parent(), bufnr)
    return namespace == '' and name or namespace .. '::' .. name
  end

  local name = node_text(declaration:field('name')[1], bufnr)
  local namespace = namespace_for(declaration:parent(), bufnr)
  if namespace == '' then
    return name
  end

  return namespace .. (is_class_method(declaration) and '.' or '#') .. name
end

function M.copy()
  local reference, err = M.reference_at_cursor()
  if not reference then
    vim.notify(err, vim.log.levels.WARN)
    return
  end

  vim.fn.setreg('+', reference)
  vim.notify('Copied Ruby reference: ' .. reference)
end

return M
