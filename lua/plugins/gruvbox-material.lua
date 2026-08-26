return {
  "sainnhe/gruvbox-material",
  -- Gruvbox with the Material palette — soft-contrast tuning aimed at
  -- long review sessions (the research doc's named alternative to
  -- kanagawa). Ships undercurl diagnostics by default.
  lazy = false,
  priority = 1000,
  config = function()
    -- Palette/contrast: 'material' foreground = designed soft contrast;
    -- 'medium' background. Switch to 'soft'/'hard' to taste, or
    -- 'original' for classic loud gruvbox.
    vim.g.gruvbox_material_background = "medium"
    vim.g.gruvbox_material_foreground = "material"
    vim.g.gruvbox_material_better_performance = 1 -- ~50% faster load
    vim.g.gruvbox_material_dim_inactive_windows = 1 -- multi-pane diff/review focus
    vim.g.gruvbox_material_ui_contrast = "high" -- legible line numbers/indent lines
    vim.g.gruvbox_material_show_eob = 0 -- no ~ noise below EOF
    -- Inlay hints get a subtle dimmed bg instead of bare grey text.
    vim.g.gruvbox_material_inlay_hints_background = "dimmed"
    -- Grey virtual text keeps WARN+ messages from shouting during review.
    vim.g.gruvbox_material_diagnostic_virtual_text = "grey"

    -- Custom highlights, per the theme's documented extension API.
    -- Must be registered BEFORE :colorscheme runs.
    local augroup = vim.api.nvim_create_augroup("gruvbox-material-custom", { clear = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = augroup,
      pattern = "gruvbox-material",
      callback = function()
        local config = vim.fn["gruvbox_material#get_configuration"]()
        local palette = vim.fn["gruvbox_material#get_palette"](
          config.background,
          config.foreground,
          config.colors_override
        )
        local set_hl = vim.fn["gruvbox_material#highlight"]

        -- Rainbow delimiters: nothing defines these highlight groups by
        -- default (plugin ships names only), so brackets would render
        -- uncolored. Map them to the theme palette so matched nesting
        -- reads as part of the scheme instead of ANSI rainbow noise.
        set_hl("RainbowDelimiterRed", palette.red, palette.none)
        set_hl("RainbowDelimiterYellow", palette.yellow, palette.none)
        set_hl("RainbowDelimiterBlue", palette.blue, palette.none)
        set_hl("RainbowDelimiterOrange", palette.orange, palette.none)
        set_hl("RainbowDelimiterGreen", palette.green, palette.none)
        set_hl("RainbowDelimiterViolet", palette.purple, palette.none)
        set_hl("RainbowDelimiterCyan", palette.aqua, palette.none)

        -- Deprecated API: strikethrough via LSP semantic-token modifier —
        -- instantly spots dead calls when reviewing unfamiliar languages.
        set_hl("@lsp.mod.deprecated", palette.grey1, palette.none, "strikethrough")

        -- Sticky context window should read as chrome, not code (defaults
        -- link to Folded, which is heavy).
        set_hl("TreesitterContext", palette.grey1, palette.bg_dim)
        set_hl("TreesitterContextLineNumber", palette.grey0, palette.bg_dim)

        -- Changed characters within a changed line (0.12 diffopt
        -- inline:char): theme default is a loud solid-blue block; swap to
        -- bold colored text on the soft blue tint so intra-line agent-diff
        -- edits pop without shouting.
        set_hl("DiffText", palette.blue, palette.bg_visual_blue, "bold")

        -- End-of-line inlay hints (nvim-lsp-endhints inherits this).
        set_hl("LspInlayHint", palette.grey0, palette.bg_dim, "italic")

        -- hunk-review.nvim line tints: the plugin ships hardcoded hexes
        -- tuned for another palette (near-invisible on this background).
        -- It defines them with default=true, so these definitions win and
        -- the review UI matches every other diff surface.
        set_hl("HunkReviewDiffBg", palette.none, palette.bg_statusline1)
        set_hl("HunkReviewAddBg", palette.none, palette.bg_diff_green)
        set_hl("HunkReviewDeleteBg", palette.none, palette.bg_diff_red)
      end,
    })

    vim.cmd.colorscheme "gruvbox-material"

    -- Day/night cycle: light mode was painful in kanagawa; here it is one
    -- option flip away.
    vim.keymap.set("n", "<leader>uT", function()
      vim.o.background = (vim.o.background == "dark") and "light" or "dark"
      vim.cmd.colorscheme "gruvbox-material"
    end, { desc = "[U]I toggle [T]heme dark/light" })
  end,
}
