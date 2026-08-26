-- C# / .NET LSP via roslyn.nvim.
--
-- PROFILE-AWARE: only loads when `dotnet` is on PATH (home-manager
-- profiles control this — work ships dotnet-sdk_10, personal doesn't).
-- Without this guard the plugin would spawn a server that can never run.
if vim.fn.executable "dotnet" == 0 then
  return {}
end

return {
  "seblyng/roslyn.nvim",
  -- Wraps the Microsoft Roslyn language server that powers the VS Code C#
  -- extension. Editing/navigation/inlay hints/Razor via co-hosting.
  lazy = true,
  ft = { "cs", "razor", "cshtml" },
  ---@module 'roslyn.config'
  ---@type RoslynNvimConfig
  opts = {
    -- Turn off filewatching on huge solutions to avoid save hangs.
    filewatching = "auto",
  },
  init = function()
    -- Launch the server DLL through the dotnet binary instead of Mason's
    -- prebuilt apphost (`bin/roslyn-language-server`). The apphost is
    -- Ubuntu-linked and dlopens libhostfxr from our Nix SDK, which needs a
    -- newer glibc than the system loader provides -> instant SIGQUIT.
    -- Running under Nix's dotnet keeps loader/libc/icu consistent.
    -- This merges over roslyn.nvim's default cmd in lsp/roslyn.lua.
    local dll = vim.fs.joinpath(
      vim.fn.stdpath "data",
      "mason",
      "packages",
      "roslyn",
      "libexec",
      "Microsoft.CodeAnalysis.LanguageServer.dll"
    )
    vim.lsp.config("roslyn", {
      cmd = { "dotnet", dll, "--stdio" },
    })

    -- Per-server settings: inlay hints + code lens + organize on format.
    -- Requires the global inlay-hint enable in lsp.lua's LspAttach
    -- autocommand to actually render.
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
