-- Helpers for mux.create="split": the agent is a real tmux pane, not an
-- embedded nvim window, so cli.toggle()/focus()/hide() become no-ops.
-- These find the running agent's pane id and act on it directly; callers
-- fall back to sidekick's default behaviour when no external session runs.

---@return string? pane_id tmux pane id (e.g. "%15") of a running agent
local function agent_pane()
  for _, s in ipairs(require("sidekick.cli.state").get({ started = true })) do
    if s.external and s.session and s.session.tmux_pane_id then
      return s.session.tmux_pane_id
    end
  end
end

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
        -- Default is "terminal": a nested tmux session inside an embedded
        -- nvim terminal window. That's invisible to our real tmux session,
        -- so C-a z / splits / navigator don't work on it. "split" makes the
        -- agent a genuine tmux pane.
        create = "split",
        split = { size = 0.4 },
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
      function()
        local pane = agent_pane()
        if pane then
          vim.system({ "tmux", "select-pane", "-t", pane })
        else
          require("sidekick.cli").focus()
        end
      end,
      mode = { "n", "i", "t", "x" },
      desc = "Focus sidekick CLI",
    },
    {
      "<leader>aa",
      function()
        -- Jump straight into the agent's tmux pane when one is running;
        -- fall back to the default toggle otherwise (embedded/no-tmux).
        local pane = agent_pane()
        if pane then
          vim.system({ "tmux", "select-pane", "-t", pane })
        else
          require("sidekick.cli").toggle()
        end
      end,
      mode = { "n", "t" },
      desc = "Sidekick Toggle CLI",
    },
    {
      -- Mirrors tmux's x=kill-pane: closes the agent pane (and its process)
      -- without leaving nvim. sidekick's own close() only detaches.
      "<leader>ax",
      function()
        local pane = agent_pane()
        if pane then
          vim.system({ "tmux", "kill-pane", "-t", pane })
        else
          vim.notify("sidekick: no external agent pane running", vim.log.levels.WARN)
        end
      end,
      mode = { "n", "t" },
      desc = "Sidekick Kill CLI pane",
    },
  },
}
