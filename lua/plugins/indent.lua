-- Indent visualization: static guides (ibl) + animated active scope
-- (mini.indentscope). ibl's `scope` is disabled to avoid overlap with
-- mini.indentscope, which owns the active-scope highlight + text objects.
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = { char = "│" },
      scope = { enabled = false },
      exclude = {
        filetypes = { "dashboard", "help", "lazy", "mason", "neo-tree", "oil", "Trouble" },
      },
    },
  },
  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local indentscope = require "mini.indentscope"
      indentscope.setup({
        symbol = "│",
        draw = { animation = indentscope.gen_animation.none() },
        options = { border = "both", indent_at_cursor = true },
      })
    end,
    init = function()
      -- Disable in filetypes where indentation is meaningless.
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("mini-indentscope-disable", { clear = true }),
        pattern = {
          "dashboard",
          "help",
          "lazy",
          "mason",
          "neo-tree",
          "oil",
          "Trouble",
          "fzf",
        },
        callback = function() vim.b.miniindentscope_disable = true end,
      })
    end,
  },
}
