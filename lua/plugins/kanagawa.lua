return {
  "rebelot/kanagawa.nvim",
  config = function()
    require("kanagawa").setup({
      compile = true,
      -- Dim inactive windows/splits so focus stays on the active pane
      -- during multi-pane review (diffview, side-by-side agent diffs).
      dimInactive = true,
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- Markdown rendering tweaks (kept from original config).
          ["@markup.link.url.markdown_inline"] = { link = "Special" },
          ["@markup.link.label.markdown_inline"] = { link = "WarningMsg" },
          ["@markup.italic.markdown_inline"] = { link = "Exception" },
          ["@markup.raw.markdown_inline"] = { link = "String" },
          ["@markup.list.markdown"] = { link = "Function" },
          ["@markup.quote.markdown"] = { link = "Error" },
          ["@markup.list.checked.markdown"] = { link = "WarningMsg" },

          -- Inlay hints: readable dim color (overrides the commented-out
          -- NonText link in kanagawa's defaults).
          LspInlayHint = { fg = theme.ui.fg_dim, italic = true },

          -- Semantic tokens: uncomment the useful links kanagawa ships
          -- disabled. Gives richer, more consistent coloring once the LSP
          -- attaches — valuable when reviewing unfamiliar languages where
          -- treesitter highlighting is weak.
          ["@lsp.type.class"] = { link = "Structure" },
          ["@lsp.type.decorator"] = { link = "Function" },
          ["@lsp.type.enum"] = { link = "Structure" },
          ["@lsp.type.enumMember"] = { link = "Constant" },
          ["@lsp.type.function"] = { link = "Function" },
          ["@lsp.type.interface"] = { link = "Structure" },
          ["@lsp.type.property"] = { link = "Identifier" },
          ["@lsp.type.struct"] = { link = "Structure" },
          ["@lsp.type.type"] = { link = "Type" },
          ["@lsp.type.typeParameter"] = { link = "TypeDef" },
        }
      end,
    })
    vim.cmd "colorscheme kanagawa"
  end,
  build = function() vim.cmd "KanagawaCompile" end,
}
