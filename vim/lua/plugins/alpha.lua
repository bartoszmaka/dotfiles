return {
  'goolord/alpha-nvim',
  dependencies = { "nvim-tree/nvim-web-devicons", name = "tree-nvim-web-devicons" },
  event = 'VimEnter',
  opts = function ()


    local dashboard = require("alpha.themes.dashboard")
    require("alpha.term")
    local logo = [[

       ███████████           █████      ██
      ███████████             █████ 
      ████████████████ ███████████ ███   ███████
     ████████████████ ████████████ █████ ██████████████
    █████████████████████████████ █████ █████ ████ █████
  ██████████████████████████████████ █████ █████ ████ █████
 ██████  ███ █████████████████ ████ █████ █████ ████ ██████
 ██████   ██  ███████████████   ██ █████████████████

    ]]

    local function getGreeting(name)
      local tableTime = os.date("*t")
      local datetime = os.date(" %Y-%m-%d   %H:%M   ")
      local hour = tableTime.hour
      local greetingsTable = {
        [1] = "  Sleep well",
        [2] = "  Good morning",
        [3] = "  Good afternoon",
        [4] = "  Good evening",
        [5] = "󰖔  Good night",
      }
      local greetingIndex = 0
      if hour == 23 or hour < 7 then
        greetingIndex = 1
      elseif hour < 12 then
        greetingIndex = 2
      elseif hour >= 12 and hour < 18 then
        greetingIndex = 3
      elseif hour >= 18 and hour < 21 then
        greetingIndex = 4
      elseif hour >= 21 then
        greetingIndex = 5
      end
      return "\t\t\t\t\t" .. datetime .. "\t" .. greetingsTable[greetingIndex] .. ", " .. name
    end

    local userName = "Bartosz"
    local greeting = getGreeting(userName)
    dashboard.section.header.val = vim.split(logo .. "\n" .. greeting, "\n")
    dashboard.section.buttons.val = {
      dashboard.button("n"            , "  New file"                        , [[:enew <CR>]])                                              ,
      dashboard.button("⌘ p"          , "󰕕  Fuzzy finder file"               , [[:FzfLua files<CR>]])                                       ,
      dashboard.button("⌃p ⌃r"        , "  Recently opened files"           , [[:FzfLua oldfiles<CR>]])                                    ,
      dashboard.button("⌘ ⇧ p"        , "  Fuzzy finder actions"            , [[:FzfLua<CR>]])                                             ,
      dashboard.button("⌘ ⇧ e"        , "  Open files tree"                 , [[:Neotree filesystem<CR>]])                                 ,
      dashboard.button("⌃ ⇧ g"        , "  Open git changed files explorer" , [[:Neotree git_status<CR>]])                                 ,
      dashboard.button("⌘ ⇧ f"        , "  Show finder"                     , [[:lua require("fzf-lua").live_grep()<CR>]])                 ,
      dashboard.button("⌘ ⇧ m"        , "  Show errors"                     , [[:lua require("fzf-lua").lsp_workspace_diagnostics()<CR>]]) ,
      dashboard.button("⌘ b"          , "  Toggle side panel"               , [[:Neotree close<CR>]])                                      ,
      dashboard.button("⌃ `"          , "  Show terminal"                   , [[:FloatermToggle<CR>]])                                     ,
      dashboard.button("SPC p g"      , "  Fuzzy browse git changes"        , [[:FzfLua git_status<CR>]])                                  ,
      -- dashboard.button("⌃k ⌃e    " , "  Open file explorer"              , [[:Neotree filesystem<CR>]])                                 ,
      -- dashboard.button("⌘ + ⇧ + c" , "  Show copilot chat (custom)"      , [[]])                                                        ,
      -- dashboard.button("⌃ + ⇧ + `" , "Toggle bottom terminal"             , [[]])                                                        ,
      -- dashboard.button("⌥ + [    " , "Previous Copilot suggestion  "      , [[]])                                                        ,
      -- dashboard.button("⌥ + ]    " , "Previous Copilot suggestion  "      , [[]])                                                        ,
      -- dashboard.button("⌘ + ⇧ + t" , "Go to latest tab (or buffer)"       , [[]])                                                        ,
    }


    -- set highlight
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"
    dashboard.opts.layout[1].val = 8

    return dashboard
  end,
  config = function (_, dashboard)
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        local version = " v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
        local plugins = "⚡Neovim loaded [" .. stats.loaded .. "/" .. stats.count .. "] plugins in " .. ms .. "ms"
        local footer = version .. "\t" .. plugins .. "\n"
        dashboard.section.footer.val = footer
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end
};
