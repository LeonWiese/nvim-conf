return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-textobjects', build = ':TSUpdate' },
  },
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'c_sharp', 'http' },
      ignore_install = {},
      sync_install = false,
      -- Autoinstall languages that are not installed
      auto_install = true,
      modules = {},

      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
      incremental_selection = {
        enable = true,
        keymaps = {
          -- init_selection = 'gs',
          node_incremental = 'gsn',
          scope_incremental = 'gss',
          node_decremental = 'gsd',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = { query = '@function.outer', desc = 'function' },
            ['if'] = { query = '@function.inner', desc = 'function' },
            ['ac'] = { query = '@class.outer', desc = 'class' },
            ['ic'] = { query = '@class.inner', desc = 'class' },
            ['ai'] = { query = '@conditional.outer', desc = 'conditional' },
            ['ii'] = { query = '@conditional.inner', desc = 'conditional' },
            ['al'] = { query = '@loop.outer', desc = 'loop' },
            ['il'] = { query = '@loop.inner', desc = 'loop' },
            ['ap'] = { query = '@parameter.outer', desc = 'parameter' },
            ['ip'] = { query = '@parameter.inner', desc = 'parameter' },
            ['aB'] = { query = '@block.outer', desc = 'block' },
            ['iB'] = { query = '@block.inner', desc = 'block' },
            ['gS'] = { query = '@local.scope', query_group = 'locals', desc = 'Scope' },
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']f'] = { query = '@function.outer', desc = 'Next function start' },
            [']c'] = { query = '@class.outer', desc = 'Next class start' },
            [']i'] = { query = '@conditional.outer', desc = 'Next conditional start' },
            [']l'] = { query = '@loop.outer', desc = 'Next loop start' },
            [']p'] = { query = '@parameter.outer', desc = 'Next parameter start' },
            [']s'] = { query = '@local.scope', query_group = 'locals', desc = 'Next scope start' },
            [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
          },
          goto_next_end = {
            [']F'] = { query = '@function.outer', desc = 'Next function end' },
            [']C'] = { query = '@class.outer', desc = 'Next class end' },
            [']I'] = { query = '@conditional.outer', desc = 'Next conditional end' },
            [']L'] = { query = '@loop.outer', desc = 'Next loop end' },
            [']P'] = { query = '@parameter.outer', desc = 'Next parameter end' },
            [']S'] = { query = '@local.scope', query_group = 'locals', desc = 'Next scope end' },
          },
          goto_previous_start = {
            ['[f'] = { query = '@function.outer', desc = 'Previous function start' },
            ['[c'] = { query = '@class.outer', desc = 'Previous class start' },
            ['[i'] = { query = '@conditional.outer', desc = 'Previous conditional start' },
            ['[l'] = { query = '@loop.outer', desc = 'Previous loop start' },
            ['[p'] = { query = '@parameter.outer', desc = 'Previous parameter start' },
            ['[s'] = { query = '@local.scope', query_group = 'locals', desc = 'Previous scope start' },
            ['[z'] = { query = '@fold', query_group = 'folds', desc = 'Previous fold' },
          },
          goto_previous_end = {
            ['[F'] = { query = '@function.outer', desc = 'Previous function end' },
            ['[C'] = { query = '@class.outer', desc = 'Previous class end' },
            ['[I'] = { query = '@conditional.outer', desc = 'Previous conditional end' },
            ['[L'] = { query = '@loop.outer', desc = 'Previous loop end' },
            ['[P'] = { query = '@parameter.outer', desc = 'Previous parameter end' },
            ['[S'] = { query = '@local.scope', query_group = 'locals', desc = 'Previous scope end' },
          },
        },
      },
    }

    local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'
    vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)

    -- Make builtin f, F, t, T also repeatable with ; and ,
    vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
  end,
}
