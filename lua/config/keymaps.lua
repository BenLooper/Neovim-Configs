-- File navigation
vim.keymap.set(
  "n",
  "<Leader>e",
  "<cmd>Oil --preview --float<CR>",
  { desc = "Open parent directory in Oil" }
)

-- Clear search highlighting with normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Window navigation: handled by vim-tmux-navigator.lua (C-h/j/k/l move
-- across both nvim splits and tmux panes seamlessly).

-- Autocommand to highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- LSP
vim.keymap.set(
  "n",
  "gl",
  function() vim.diagnostic.open_float() end,
  { desc = "Open diagnostics in float" }
)

-- Formatting
vim.keymap.set(
  "n",
  "<leader>cf",
  function()
    require("conform").format({
      lsp_format = "fallback",
    })
  end,
  { desc = "Format current file" }
)
