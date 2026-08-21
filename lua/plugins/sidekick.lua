return {
  "folke/sidekick.nvim",
  -- Prompt library + Copilot LSP Next Edit Suggestions (NES). The
  -- `mux.backend = "tmux"` runs the agent in an external tmux pane
  -- (matching the existing C-a h/j/k/l tmux nav) instead of embedded —
  -- the consensus workflow for reviewing agent code.
  -- Requires Neovim >= 0.11.2 (we're on 0.12.4).
  event = "VeryLazy",
  opts = {
    cli = {
      mux = {
        backend = "tmux",
        enabled = true,
      },
    },
  },
  keys = {
    {
      "<tab>",
      function()
        if require("sidekick").nes_jump_or_apply() then
          return
        end
        if vim.lsp.inline_completion and vim.lsp.inline_completion.get() then
          return
        end
        return "<tab>"
      end,
      mode = { "i", "n" },
      expr = true,
      desc = "NES / inline completion / Tab",
    },
    {
      "<c-.>",
      function() require("sidekick.cli").focus() end,
      mode = { "n", "i", "t", "x" },
      desc = "Focus sidekick CLI",
    },
  },
}
