return {
  "barrettruth/diffs.nvim",
  -- Treesitter syntax highlighting for diffs inside fugitive/built-in diff
  -- filetype, plus word/char-level intra-line diff highlighting (0.12
  -- diffopt inline:char). Configured via the `vim.g.diffs` global read by
  -- its plugin/ dir at load time — there is NO setup() function, so this
  -- spec must not use `opts = {}` (lazy would call require("diffs").setup
  -- and error). Defaults are fine: treesitter + intra highlighting on.
  event = { "BufReadPost", "BufNewFile" },
}
