-- Go to previous unmatched '['
local function goto_prev_unmatched(char, closing_char)
  return function()
    local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
    local bracket_count = 0

    for current_row = cursor_row, 1, -1 do
      local line = vim.fn.getline(current_row)
      local start_col = current_row == cursor_row and cursor_col or #line

      for current_col = start_col, 1, -1 do
        local current_char = line:sub(current_col, current_col)

        if current_char == closing_char then
          bracket_count = bracket_count + 1
        elseif current_char == char then
          if bracket_count == 0 then
            vim.api.nvim_win_set_cursor(0, { current_row, current_col - 1 })
            return
          else
            bracket_count = bracket_count - 1
          end
        end
      end
    end

    print('No unmatched ' .. char)
  end
end

-- Go to next unmatched ']'
local function goto_next_unmatched(char, closing_char)
  return function()
    local total_lines = vim.fn.line '$'
    local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
    local bracket_count = 0

    for current_row = cursor_row, total_lines do
      local line = vim.fn.getline(current_row)
      local start_col = current_row == cursor_row and (cursor_col + 2) or 1

      for current_col = start_col, #line do
        local current_char = line:sub(current_col, current_col)

        if current_char == closing_char then
          bracket_count = bracket_count + 1
        elseif current_char == char then
          if bracket_count == 0 then
            vim.api.nvim_win_set_cursor(0, { current_row, current_col - 1 })
            return
          else
            bracket_count = bracket_count - 1
          end
        end
      end
    end

    print('No unmatched ' .. char)
  end
end

local M = {}

function M.setup()
  vim.keymap.set({ 'n', 'v', 'o' }, '[[', goto_prev_unmatched('[', ']'), { desc = 'Previous [' })
  vim.keymap.set({ 'n', 'v', 'o' }, ']]', goto_next_unmatched(']', '['), { desc = 'Next [' })
end

return M
