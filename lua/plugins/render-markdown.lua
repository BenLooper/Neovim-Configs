return {
  "MeanderingProgrammer/render-markdown.nvim",
  -- Persistent markdown rendering across modes (beats markview for review:
  -- rendering doesn't disappear on cursor move). Agents emit huge volumes
  -- of markdown (plans, summaries, docs) — this makes it legible.
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "markdown", "norg", "rmd", "org" },
  opts = {
    anti_conceal = { enabled = true },
    render_modes = { "n", "c", "t" },
  },
}
