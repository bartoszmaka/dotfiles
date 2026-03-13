return {
  {
    "rebelot/heirline.nvim",
    event = "UiEnter",
    dependencies = {
      "navarasu/onedark.nvim",
    },
    config = function()
      local nnoremap = require("helper").nnoremap
      local components = require("helper.heirline_components")

      local function listed_buffers()
        local bufs = {}
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted then
            table.insert(bufs, bufnr)
          end
        end
        return bufs
      end

      local function goto_buffer(index)
        local bufs = listed_buffers()
        local target = bufs[index]
        if target then
          vim.api.nvim_set_current_buf(target)
        end
      end

      local function close_other_buffers()
        local current = vim.api.nvim_get_current_buf()
        for _, bufnr in ipairs(listed_buffers()) do
          if bufnr ~= current then
            vim.api.nvim_buf_delete(bufnr, {})
          end
        end
      end

      local function close_matchup_window_and_then_close_buffer()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local config = vim.api.nvim_win_get_config(win)
          local is_matchup_popup_window = (config.anchor == "NW" or config.anchor == "SW")
            and config.external == false
            and config.focusable == false
            and config.zindex == 50
            and config.relative == "win"

          if is_matchup_popup_window then
            vim.api.nvim_win_close(win, true)
          end
        end

        vim.api.nvim_buf_delete(0, {})
      end

      vim.opt.laststatus = 3
      vim.opt.showtabline = 2

      require("heirline").setup({
        statusline = components.statusline,
        tabline = nil,
        statuscolumn = components.statuscolumn,
      })

      -- nnoremap("<leader>{", "<cmd>bprevious<CR>", { silent = true })
      -- nnoremap("<leader>}", "<cmd>bnext<CR>", { silent = true })
      -- nnoremap("<leader>1", function() goto_buffer(1) end, { silent = true })
      -- nnoremap("<leader>2", function() goto_buffer(2) end, { silent = true })
      -- nnoremap("<leader>3", function() goto_buffer(3) end, { silent = true })
      -- nnoremap("<leader>4", function() goto_buffer(4) end, { silent = true })
      -- nnoremap("<leader>5", function() goto_buffer(5) end, { silent = true })
      -- nnoremap("<leader>6", function() goto_buffer(6) end, { silent = true })
      -- nnoremap("<leader>7", function() goto_buffer(7) end, { silent = true })
      -- nnoremap("<leader>8", function() goto_buffer(8) end, { silent = true })
      -- nnoremap("<leader>9", function()
      --   local bufs = listed_buffers()
      --   goto_buffer(#bufs)
      -- end, { silent = true })
      --
      -- nnoremap("<leader>q", "<cmd>close<CR>")
      -- nnoremap("<leader>w", close_matchup_window_and_then_close_buffer)
      -- nnoremap("<leader>`", "<cmd>b#<CR>")
      -- nnoremap("<leader><leader>!", close_other_buffers)
    end,
  },
}
