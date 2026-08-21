return {
  {
    "amansingh-afk/milli.nvim",
    lazy = false,
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      local splash = require("milli").load({ splash = "blackhole" })
      require("dashboard").setup({
        theme = "doom",
        disable_move = true,
        config = {
          header = splash.frames[1],
          center = {
            {
              icon = "󰙅 ",
              icon_hl = "Title",
              desc = "File Explorer",
              desc_hl = "String",
              key = "e",
              keymap = "SPC e",
              key_hl = "Number",
              key_format = " %s",
              action = "Oil --preview --float",
            },
            {
              icon = "󰋙 ",
              icon_hl = "Title",
              desc = "Recent Files",
              desc_hl = "String",
              key = "r",
              keymap = "SPC f o",
              key_hl = "Number",
              key_format = " %s",
              action = "lua require('fzf-lua').oldfiles()",
            },
            {
              icon = "󰈱 ",
              icon_hl = "Title",
              desc = "Find Word",
              desc_hl = "String",
              key = "g",
              keymap = "SPC f g",
              key_hl = "Number",
              key_format = " %s",
              action = "lua require('fzf-lua').live_grep()",
            },
            {
              icon = "󰒍 ",
              icon_hl = "Title",
              desc = "Session Picker",
              desc_hl = "String",
              key = "s",
              keymap = "SPC f s",
              key_hl = "Number",
              key_format = " %s",
              action = "PersistenceSelect",
            },
            {
              icon = "󰦛 ",
              icon_hl = "Title",
              desc = "Restore Session",
              desc_hl = "String",
              key = "s",
              keymap = "SPC q s",
              key_hl = "Number",
              key_format = " %s",
              action = "PersistenceLoad",
            },
          },
          footer = {},
          vertical_center = false,
        },
      })
      require("milli").dashboard({ splash = "blackhole", loop = true })
      vim.api.nvim_create_user_command(
        "PersistenceSelect",
        function() require("persistence").select() end,
        {}
      )
      vim.api.nvim_create_user_command(
        "PersistenceLoad",
        function() require("persistence").load() end,
        {}
      )
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
