return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    max_lines = 3,
    multiline_threshold = 20,
    trim_scope = "outer",
    mode = "cursor",
    separator = nil,
  },
  keys = {
    { "[c", false, desc = "TS-context: jump to context (disabled default)" },
    {
      "<leader>ux",
      function() require("treesitter-context").toggle() end,
      desc = "Toggle treesitter context",
    },
  },
}
