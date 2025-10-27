return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    local ascii_art = require('art')
    require('dashboard').setup {
      theme = 'doom',    -- theme is doom and hyper default is hyper
      disable_move = true,      -- default is false disable move keymap for hyper
      -- shortcut_type = 'letter',     -- shortcut type 'letter' or 'number'
      config = {
        header = ascii_art.hobbitHole,
        center = {
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Find File           ',
            desc_hl = 'String',
            key = 'a',
            keymap = 'SPC f f',
            key_hl = 'Number',
            key_format = ' %s', -- remove default surrounding `[]`
            action = 'lua print(2)'
          },
          {
            icon = ' ',
            desc = 'Find Dotfiles',
            key = 'f',
            keymap = 'SPC f d',
            key_format = ' %s', -- remove default surrounding `[]`
            action = 'lua print(3)'
          },
        },
        footer = {},
        vertical_center = false, -- Center the Dashboard on the vertical (from top to bottom)
      },
    }
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
}
