return {
  "sindrets/diffview.nvim",
  -- Structured multi-file diffs. `enhanced_diff_hl` syntax-highlights
  -- BOTH sides instead of one flat highlight group — the key legibility
  -- switch. Pairs with 0.12's `diffopt=inline:char` for word/char-level
  -- intra-line highlighting.
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose", "DiffviewToggleFiles" },
  opts = {
    enhanced_diff_hl = true,
    use_icons = true,
    view = {
      default = { layout = "diff2_horizontal" },
      merge_tool = { layout = "diff3_horizontal" },
    },
    file_panel = {
      listing_style = "tree",
      win_config = { position = "left", width = 35 },
    },
  },
  keys = {
    { "<leader>gv", "<cmd>DiffviewOpen<CR>", desc = "Diffview: open working tree" },
    {
      "<leader>gV",
      "<cmd>DiffviewOpen main...HEAD<CR>",
      desc = "Diffview: branch review (main...HEAD)",
    },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Diffview: file history" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<CR>", desc = "Diffview: repo history" },
    { "<leader>gc", "<cmd>DiffviewClose<CR>", desc = "Diffview: close" },
  },
}
