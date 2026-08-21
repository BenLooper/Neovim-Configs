return {
  "folke/todo-comments.nvim",
  -- Highlight TODO/FIXME/NOTE/BUG/HACK/WARN and provide fzf integration.
  -- Helps surface agent-generated todos while reviewing unfamiliar code.
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    signs = true,
    keywords = {
      FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      TEST = { icon = "⭕", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
  },
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev todo comment" },
    { "<leader>ft", "<cmd>TodoFzfLua<CR>", desc = "Find todos" },
    { "<leader>xt", "<cmd>TodoTrouble<CR>", desc = "Todos in trouble" },
  },
}
