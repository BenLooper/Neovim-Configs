return {
  "shaunchander/hunk-review.nvim",
  -- Batch review with inline comments on hunks/lines/ranges, treesitter-
  -- highlighted diffs, LSP peek into source (go-to-def, hover, diagnostics
  -- from within the review), and structured JSON export you paste back to
  -- the agent. Auto-detects base/target branches (stacked-PR aware).
  -- This is the annotate-and-return loop — the direct answer to
  -- "I can't keep up reviewing agent code."
  -- Depends on snacks.nvim. Young plugin — expect churn; pin if needed.
  dependencies = { "folke/snacks.nvim" },
  cmd = { "HunkReview" },
  opts = {},
}
