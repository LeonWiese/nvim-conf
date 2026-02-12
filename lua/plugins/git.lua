return {
  'NeogitOrg/neogit',
  lazy = true,
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'sindrets/diffview.nvim',
      opts = {
        enhanced_diff_hl = true,
      },
    },
    'nvim-telescope/telescope.nvim',
  },
  opts = {
    graph_style = 'kitty',
  },
  cmd = 'Neogit',
  keys = {
    { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Show NeoGit UI' },
  },
}
