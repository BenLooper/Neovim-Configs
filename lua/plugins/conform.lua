return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts = opts or {}
    local formatters_by_ft = {
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
    }
    -- PROFILE-AWARE: csharpier is a dotnet tool — only register it when the
    -- .NET SDK is on PATH (work profile).
    if vim.fn.executable "dotnet" == 1 then
      formatters_by_ft.cs = { "csharpier" }
    end
    opts.formatters_by_ft = formatters_by_ft
    opts.format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    }
    return opts
  end,
}
