return {
  "HiPhish/rainbow-delimiters.nvim",
  -- Color-matched brackets/parens. Enabled per-filetype only — the
  -- research consensus is rainbow delimiters help with deeply-nested
  -- unfamiliar code (JSON, YAML, Lua, Nix, TS generics) but are noise
  -- in ordinary code.
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    -- Only enable for filetypes where deep nesting is common.
    vim.g.rainbow_delimiters = {
      query = {
        lua = "rainbow-delimiters",
        json = "rainbow-delimiters",
        yaml = "rainbow-delimiters",
        nix = "rainbow-delimiters",
        typescript = "rainbow-delimiters",
        tsx = "rainbow-delimiters",
      },
      highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      },
    }
  end,
}
