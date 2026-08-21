return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
  },
  opts = {
    open_mapping = [[<leader>tt]],
    direction = "float",
    float_opts = {
      border = "curved",
    },
  },
}
