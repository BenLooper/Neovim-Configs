return {
  "lewis6991/gitsigns.nvim",
  -- Git diff signs in the gutter + inline blame + hunk navigation.
  -- Auto-refreshes on stage/unstage; pairs with diffview.
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    signs_staged_enable = true,
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 300,
      virt_text_pos = "eol",
    },
  },
  keys = {
    { "]h", function() require("gitsigns").nav_hunk "next" end, desc = "Next git hunk" },
    { "[h", function() require("gitsigns").nav_hunk "prev" end, desc = "Prev git hunk" },
    {
      "<leader>hs",
      function() require("gitsigns").stage_hunk() end,
      desc = "Stage hunk",
      mode = { "n", "v" },
    },
    {
      "<leader>hr",
      function() require("gitsigns").reset_hunk() end,
      desc = "Reset hunk",
      mode = { "n", "v" },
    },
    { "<leader>hp", function() require("gitsigns").preview_hunk() end, desc = "Preview hunk" },
    {
      "<leader>hb",
      function() require("gitsigns").blame_line({ full = true }) end,
      desc = "Blame line (full)",
    },
    { "<leader>hd", function() require("gitsigns").diffthis() end, desc = "Diff this" },
  },
}
