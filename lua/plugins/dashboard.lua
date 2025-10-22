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
            icon = '',
            icon_hl = 'group',
            desc = 'description',
            desc_hl = 'group',
            key = 'shortcut key in dashboard buffer not keymap !!',
            key_hl = 'group',
            key_format = ' [%s]', -- `%s` will be substituted with value of `key`
            action = '',
          },
        },
        footer = {},
        vertical_center = false, -- Center the Dashboard on the vertical (from top to bottom)
      },
    }
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
}
