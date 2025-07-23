local M = {}

--- @class project-config.config
--- @field shortcut? string
--- @field desc string
--- @field cmd function

--- @type project-config.config[]
local registered = {}

--- Register a configuration like this:
--- ```lua
--- local project_config = require("project-config")
--- project_config.register {
---     desc = "Run server",
---     cmd = function()
---         vim.cmd("vsplit | vertical resize -30 | terminal npm run start")
---     end,
---     shortcut = "<leader>wr",
--- }
--- ```
---
--- @param config project-config.config
function M.register(config)
    table.insert(registered, config)

    if config.shortcut then
        vim.keymap.set("n", config.shortcut, config.cmd, { desc = config.desc })
    end
end

function M.show_list()
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local actions = require("telescope.actions")
    local actions_state = require("telescope.actions.state")

    pickers
        .new({}, {
            prompt_title = "Run workspace action",
            finder = finders.new_table {
                results = registered,
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = entry.desc,
                        ordinal = entry.desc,
                    }
                end,
            },
            attach_mappings = function(prompt_bufnr)
                actions.select_default:replace(function()
                    local selection = actions_state.get_selected_entry()
                    if selection and selection.value.cmd then
                        selection.value.cmd()
                    end
                    actions.close(prompt_bufnr)
                end)
                return true
            end,
        })
        :find()
end

function M.setup() end

return M
