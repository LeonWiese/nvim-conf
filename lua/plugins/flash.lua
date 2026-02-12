return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  config = function()
    require('flash').setup {
      label = {
        uppercase = false,
      },
      highlight = {
        backdrop = false,
      },
      modes = {
        char = {
          enabled = false,
        },
      },
    }
    require('darcula').apply_flash()
  end,
  keys = {
    {
      '<leader>f',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
  },
}
