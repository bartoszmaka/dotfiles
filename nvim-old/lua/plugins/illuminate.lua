-- return {
--   'RRethy/vim-illuminate',
--   config = function()
--     require('illuminate').configure({
--       delay = 200
--     })

--     vim.cmd[[
--       augroup illuminate_overrides
--         autocmd!
--         highlight! illuminatedWord guibg=#314365
--         highlight! illuminatedCurWord guibg=#314365 gui=bold
--         highlight! link IlluminatedWordRead illuminatedWord
--         highlight! link IlluminatedWordWrite illuminatedWord
--         highlight! link IlluminatedWordText None
--       augroup END
--     ]]
--   end
-- }
return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    delay = 200,
    filetypes_denylist = { 'lua' }
  },
  config = function(_, opts)
    require("illuminate").configure(opts)

    local function map(key, dir, buffer)
      vim.keymap.set("n", key, function()
        require("illuminate")["goto_" .. dir .. "_reference"](false)
      end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
    end

    map("]]", "next")
    map("[[", "prev")

    -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        local buffer = vim.api.nvim_get_current_buf()
        map("]]", "next", buffer)
        map("[[", "prev", buffer)
      end,
    })
  end,
  keys = {
    { "]]", desc = "Next Reference" },
    { "[[", desc = "Prev Reference" },
  },
}
