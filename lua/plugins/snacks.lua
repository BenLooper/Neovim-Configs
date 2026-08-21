return {
  "folke/snacks.nvim",
  -- Required by hunk-review.nvim. We only enable the `terminal` module
  -- here (indent visualization is handled by ibl + mini.indentscope).
  -- The terminal module gives sidekick.nvim a backend for sending prompts
  -- to an agent CLI in an adjacent tmux pane.
  priority = 1000,
  lazy = false,
  opts = {
    terminal = { win = { border = "rounded" } },
  },
}
