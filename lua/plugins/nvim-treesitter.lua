return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  config = function()
    -- Parsers to install and keep installed. The new `main`-branch API
    -- uses `require("nvim-treesitter").install(...)` instead of the old
    -- `ensure_installed` table on `setup()`.
    local parsers = {
      "c",
      "lua",
      "vim",
      "vimdoc",
      "query",
      "elixir",
      "heex",
      "javascript",
      "typescript",
      "tsx",
      "html",
      "css",
      "json",
      "yaml",
      "toml",
      "markdown",
      "markdown_inline",
      "python",
      "go",
      "gomod",
      "gosum",
      "rust",
      "nix",
      "c_sharp",
      "angular",
    }

    -- Install missing parsers. Wrapped in pcall because the `tree-sitter`
    -- CLI may not be available (e.g. on NixOS without it in PATH). Parser
    -- compilation failures are non-fatal — highlighting just won't work
    -- for those languages until the CLI is installed.
    local installed = require("nvim-treesitter").get_installed()
    local have = {}
    for _, lang in ipairs(installed) do
      have[lang] = true
    end
    local missing = {}
    for _, lang in ipairs(parsers) do
      if not have[lang] then
        table.insert(missing, lang)
      end
    end
    if #missing > 0 then
      pcall(require("nvim-treesitter").install, missing)
    end

    -- Highlight and indent are native on 0.11+: `vim.treesitter.start()`
    -- handles both. No `highlight = { enable = true }` module needed.
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("nvim-treesitter-start", { clear = true }),
      callback = function(args) pcall(vim.treesitter.start, args.buf) end,
    })

    -- Folding: built-in treesitter foldexpr (0.11+). Try this before ufo.
    vim.o.foldmethod = "expr"
    vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.o.foldlevel = 99
  end,
}
