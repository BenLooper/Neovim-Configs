return {
  "Bekaboo/dropbar.nvim",
  -- dropbar needs 0.12 (we're on 0.12.4). Breadcrumbs in winbar with
  -- interactive drop-down menus — "where am I" context for unfamiliar code.
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim", -- optional fzf sorter
  },
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    menu = {
      win_configs = {
        border = "rounded",
      },
    },
    sources = {
      path = {
        modified = function(sym) return sym.data and sym.data.modified end,
      },
    },
  },
  keys = {
    {
      "<leader>;",
      function() require("dropbar.api").pick() end,
      desc = "Pick dropbar breadcrumb",
    },
    {
      "[<Tab>",
      function() require("dropbar.api").goto_context_start() end,
      desc = "Go to dropbar context start",
    },
    {
      "]<Tab>",
      function() require("dropbar.api").select_next_context() end,
      desc = "Select next dropbar context",
    },
  },
}
