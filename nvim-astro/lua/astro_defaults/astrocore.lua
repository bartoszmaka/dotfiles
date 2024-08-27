-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec

return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    features = { -- Configure core features of AstroNvim
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true,                                 -- enable autopairs at start
      cmp = true,                                       -- enable completion at start
      diagnostics_mode = 3,                             -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true,                              -- highlight URLs at start
      notifications = true,                             -- enable notifications at start
    },
    diagnostics = {  -- -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
      virtual_text = true,
      underline = false,
    },
    options = { -- -- vim options can be configured here
      opt = {                   -- vim.opt.<key>
        relativenumber = false, -- sets vim.opt.relativenumber
        number = true,          -- sets vim.opt.number
        spell = false,          -- sets vim.opt.spell
        signcolumn = "yes",     -- sets vim.opt.signcolumn to yes
        wrap = false,           -- sets vim.opt.wrap
        cmdheight = 1,
        scrolloff = 4,
      },
      g = {                     -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      n = {
        ["[e"] = { function() vim.diagnostic.goto_prev() end, desc = "Prev Diagnostics" },
        ["]e"] = { function() vim.diagnostic.goto_next() end, desc = "Next Diagnostics" },
        ["[d"] = false,
        ["]d"] = false,
        ["[w"] = false,
        ["]w"] = false,
        ["<Leader>]"] = false,
        ["<Leader>["] = false,
        ["<Leader>1"] = false,
        ["<Leader>2"] = false,
        ["<Leader>3"] = false,
        ["<Leader>4"] = false,
        ["<Leader>5"] = false,
        ["<Leader>6"] = false,
        ["<Leader>7"] = false,
        ["<Leader>8"] = false,
        ["<Leader>9"] = false,
        ["<Leader>}"] = false,
        ["<Leader>{"] = false,
        ["<Leader>w"] = false,
        -- ["<Leader>]"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        -- ["<Leader>["] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        -- ["<Leader>1"] = { function() require("astrocore.buffer").nav_to(1) end, desc = "Go to buffer 1" },
        -- ["<Leader>2"] = { function() require("astrocore.buffer").nav_to(2) end, desc = "Go to buffer 2" },
        -- ["<Leader>3"] = { function() require("astrocore.buffer").nav_to(3) end, desc = "Go to buffer 3" },
        -- ["<Leader>4"] = { function() require("astrocore.buffer").nav_to(4) end, desc = "Go to buffer 4" },
        -- ["<Leader>5"] = { function() require("astrocore.buffer").nav_to(5) end, desc = "Go to buffer 5" },
        -- ["<Leader>6"] = { function() require("astrocore.buffer").nav_to(6) end, desc = "Go to buffer 6" },
        -- ["<Leader>7"] = { function() require("astrocore.buffer").nav_to(7) end, desc = "Go to buffer 7" },
        -- ["<Leader>8"] = { function() require("astrocore.buffer").nav_to(8) end, desc = "Go to buffer 8" },
        -- ["<Leader>9"] = { function() require("astrocore.buffer").nav_to(9) end, desc = "Go to buffer 9" },
        -- ["<Leader>}"] = { function() require("astrocore.buffer").move(vim.v.count1) end, desc = "Move buffer next" },
        -- ["<Leader>{"] = { function() require("astrocore.buffer").move(-vim.v.count1) end, desc = "Move buffer prev" },
        -- ["<Leader>w"] = { function() require("astrocore.buffer").close() end, desc = "Close buffer" },
        -- setting a mapping to false will disable it
        ["<Leader>d"] = false,
        ["<Leader>c"] = false,
        ["<Leader>ld"] = false,
        ["<Leader>lD"] = false,
        ["<Leader>ls"] = false,
        ["<Leader>lS"] = false,
        ["gra"] = false,
        ["grr"] = false,
        ["grn"] = false,
        ["<C-k><C-v>"] = { function() require('aerial').toggle() end, desc = "Toggle symbols outline"},
      },
    },
  },
}
