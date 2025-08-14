return {
  {
    'folke/snacks.nvim',
    priority = 999,
    lazy = false,
    ---@module 'snacks'
    ---@type snacks.Config
    opts = {
      dashboard = {
        sections = {
          {
            section = 'terminal',
            cmd = 'cat ~/.config/nvim/logo.txt',
            -- ttl = 1,
            align = 'right',
            height = 8,
            indent = -11,
            padding = 2,
          },
          { section = 'keys', gap = 1, padding = 1 },
          { section = 'startup' },
        },
      },
    },
  },
}
