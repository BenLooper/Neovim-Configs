return {
  "Cannon07/code-preview.nvim",
  -- Pre-disk diffs of agent edits. Intercepts an agent's proposed edit
  -- BEFORE it hits disk and opens it as a native Neovim diff with full
  -- syntax highlighting, your colorscheme, your keymaps. Accept/reject
  -- in the agent CLI. Agent-agnostic: supports Claude Code AND opencode.
  -- Install hooks per-agent after first load:
  --   :CodePreviewInstallClaudeCodeHooks
  --   :CodePreviewInstallOpenCodeHooks
  -- Young plugin (~176 stars) — expect churn; pin to a commit if needed.
  event = "VeryLazy",
  opts = {},
}
