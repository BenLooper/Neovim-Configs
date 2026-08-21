return {
  "barrettruth/diffs.nvim",
  -- Treesitter syntax highlighting for diffs inside fugitive/Neogit/built-in
  -- diff filetype, plus word/char-level highlighting. Makes existing diffs
  -- legible without changing the diff engine. Needs Neovim 0.9+.
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    bufline = false,
    default_handlers = true,
    highlight = { word = true, char = true },
  },
}
