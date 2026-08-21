return {
  "brenoprata10/nvim-highlight-colors",
  -- Render hex/rgb/named colors inline. Useful when reviewing
  -- agent-generated CSS/frontend/config with color values.
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    render = "virtual",
    enable_tailwind = true,
  },
}
