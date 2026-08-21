return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  init = function()
    -- Avoid conflicts with 0.12 built-in ftplugin textobject maps.
    vim.g.no_plugin_maps = true
  end,
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        enable = true,
        lookahead = true,
        selection_modes = {
          ["@parameter.outer"] = "v",
          ["@function.outer"] = "V",
          ["@class.outer"] = "<c-v>",
        },
        include_surrounding_whitespace = true,
      },
      move = {
        enable = true,
        set_jumps = true,
      },
    })

    local select = require "nvim-treesitter-textobjects.select"
    local move = require "nvim-treesitter-textobjects.move"
    local swap = require "nvim-treesitter-textobjects.swap"

    -- Select textobjects (x/o modes)
    local function sel(keys, capture, group, desc)
      vim.keymap.set(
        { "x", "o" },
        keys,
        function() select.select_textobject(capture, group or "textobjects") end,
        { desc = desc }
      )
    end

    sel("af", "@function.outer", nil, "Select outer function")
    sel("if", "@function.inner", nil, "Select inner function")
    sel("ac", "@class.outer", nil, "Select outer class")
    sel("ic", "@class.inner", nil, "Select inner class")
    sel("ao", "@comment.outer", nil, "Select outer comment")
    sel("as", "@local.scope", "locals", "Select language scope")

    -- Swap (n mode)
    vim.keymap.set(
      "n",
      "<leader>a",
      function() swap.swap_next "@parameter.inner" end,
      { desc = "Swap with next parameter" }
    )
    vim.keymap.set(
      "n",
      "<leader>A",
      function() swap.swap_previous "@parameter.outer" end,
      { desc = "Swap with previous parameter" }
    )

    -- Move (n/x/o modes)
    local function mv(keys, fn, capture, group, desc)
      vim.keymap.set(
        { "n", "x", "o" },
        keys,
        function() fn(capture, group or "textobjects") end,
        { desc = desc }
      )
    end

    mv("]m", move.goto_next_start, "@function.outer", nil, "Next function start")
    mv("]]", move.goto_next_start, "@class.outer", nil, "Next class start")
    mv("]o", move.goto_next_start, { "@loop.inner", "@loop.outer" }, nil, "Next loop start")
    mv("]s", move.goto_next_start, "@local.scope", "locals", "Next scope")
    mv("]z", move.goto_next_start, "@fold", "folds", "Next fold")
    mv("]M", move.goto_next_end, "@function.outer", nil, "Next function end")
    mv("][", move.goto_next_end, "@class.outer", nil, "Next class end")

    mv("[m", move.goto_previous_start, "@function.outer", nil, "Prev function start")
    mv("[[", move.goto_previous_start, "@class.outer", nil, "Prev class start")
    mv("[M", move.goto_previous_end, "@function.outer", nil, "Prev function end")
    mv("[]", move.goto_previous_end, "@class.outer", nil, "Prev class end")

    mv("]d", move.goto_next, "@conditional.outer", nil, "Next conditional")
    mv("[d", move.goto_previous, "@conditional.outer", nil, "Prev conditional")
    mv("]p", move.goto_next, "@property", nil, "Next property")
    mv("[p", move.goto_previous, "@property", nil, "Prev property")
  end,
}
