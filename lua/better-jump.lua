local function better_jump(keys)
  local buf = vim.api.nvim_get_current_buf()
  local tc = vim.api.nvim_replace_termcodes(keys, true, false, true)
  -- local done = {}

  for _ = 1, 20 do
    vim.api.nvim_feedkeys(tc, 'n', false)

    buf = vim.api.nvim_get_current_buf()
    local name = vim.api.nvim_buf_get_name(buf)
    print(name)

    if vim.api.nvim_buf_is_valid(buf) and not (name:match '^fyler://' or name:match '^oil://') then
      -- table.insert(done, 'Found valid buffer ' .. name)
      -- print(vim.inspect(done))
      return
    end
    -- table.insert(done, 'Found invalid buffer ' .. name)
  end
end

local M = {}

function M.setup()
  vim.keymap.set('n', '<C-o>', function()
    better_jump '<C-o>'
  end, { desc = 'Jump backward in jumplist' })

  vim.keymap.set('n', '<C-i>', function()
    better_jump '<C-i>'
  end, { desc = 'Jump forward in jumplist' })
end

return M
