return {
  "christoomey/vim-tmux-navigator",
  -- Unify nvim window nav (C-h/j/k/l in keymaps.lua) with tmux pane nav
  -- (C-a h/j/k/l in tmux.nix). Lets you move seamlessly between nvim splits
  -- and tmux panes — essential for the adjacent-agent workflow.
  -- NOTE: needs matching tmux-side config in home/tmux.nix (parent repo).
  lazy = false,
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<CR>", desc = "Tmux navigate left" },
    { "<C-j>", "<cmd>TmuxNavigateDown<CR>", desc = "Tmux navigate down" },
    { "<C-k>", "<cmd>TmuxNavigateUp<CR>", desc = "Tmux navigate up" },
    { "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = "Tmux navigate right" },
    { "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>", desc = "Tmux navigate previous" },
  },
}
