return {
  "chrisgrieser/nvim-lsp-endhints",
  -- Render inlay hints at end-of-line instead of within the line.
  -- Keeps vim motions/columns intact — important for a motion-heavy
  -- setup (textobjects, ]m/[m, fzf). Zero-config; overrides the
  -- textDocument/inlayHint handler.
  event = "LspAttach",
  opts = {},
}
