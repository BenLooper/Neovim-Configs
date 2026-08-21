return {
  "seblyng/roslyn.nvim",
  -- C# / .NET LSP. Wraps the Microsoft Roslyn language server that powers
  -- the VS Code C# extension. Supports editing, navigation, inlay hints,
  -- and Razor/Blazor via co-hosting (supersedes rzls.nvim).
  -- Requires Neovim >= 0.12 (we're on 0.12.4) + .NET SDK + roslyn server.
  -- Install the server via Mason (`:MasonInstall roslyn-language-server`)
  -- or as a dotnet tool (see roslyn.nvim README for the Azure DevOps feed).
  lazy = true,
  ft = { "cs", "razor", "cshtml" },
  ---@module 'roslyn.config'
  ---@type RoslynNvimConfig
  opts = {
    -- Turn off filewatching on huge solutions to avoid save hangs.
    filewatching = "auto",
  },
  init = function()
    -- Per-server settings: inlay hints + code lens. These take effect
    -- when roslyn attaches. Requires the global inlay-hint enable in
    -- lsp.lua's LspAttach autocommand (which we have).
    vim.lsp.config("roslyn", {
      settings = {
        ["csharp|inlay_hints"] = {
          csharp_enable_inlay_hints_for_types = true,
          csharp_enable_inlay_hints_for_implicit_object_creation = true,
          csharp_enable_inlay_hints_for_implicit_variable_types = true,
          csharp_enable_inlay_hints_for_lambda_parameter_types = true,
          dotnet_enable_inlay_hints_for_parameters = true,
          dotnet_enable_inlay_hints_for_literal_parameters = true,
          dotnet_enable_inlay_hints_for_object_creation_parameters = true,
          dotnet_enable_inlay_hints_for_other_parameters = true,
        },
        ["csharp|code_lens"] = {
          dotnet_enable_references_code_lens = true,
        },
        ["csharp|formatting"] = {
          dotnet_organize_imports_on_format = true,
        },
      },
    })
  end,
}
