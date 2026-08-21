return {
  "stevearc/aerial.nvim",
  -- Togglable outline sidebar with treesitter + LSP backends.
  -- treesitter fallback means it works even without a configured LSP —
  -- useful when reviewing languages you don't have an LSP for.
  keys = {
    { "<leader>o", "<cmd>AerialToggle!<CR>", desc = "Toggle outline" },
    { "{", "<cmd>AerialPrev<CR>", desc = "Aerial prev symbol" },
    { "}", "<cmd>AerialNext<CR>", desc = "Aerial next symbol" },
  },
  opts = {
    backends = { "treesitter", "lsp", "markdown" },
    layout = {
      min_width = 28,
      default_direction = "right",
      placement = "edge",
    },
    highlight_on_jump = 300,
  },
}
