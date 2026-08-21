return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff_organize_imports", "ruff_format" },
      go = { "goimports", "gofumpt" },
      rust = { "rustfmt" },
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },
      javascriptreact = { "prettierd" },
      json = { "prettierd" },
      jsonc = { "prettierd" },
      html = { "prettierd" },
      css = { "prettierd" },
      yaml = { "prettierd" },
      markdown = { "prettierd" },
      nix = { "nixfmt" },
      cs = { "csharpier" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
