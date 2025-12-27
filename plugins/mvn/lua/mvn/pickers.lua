local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

---@class Config
---@field title string
---@field listing table
---@field callback function
---@field mapping function|nil

---@param config Config
---@param opts table
M.pickers_menu = function(config, opts)
    opts = opts or {}
    pickers.new(opts, {
        prompt_title = config.title,
        finder = finders.new_table({
            results = config.listing
        }),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            if opts.mapping ~= nil then
                opts.mappings(map, actions, action_state)
            end

            actions.select_default:replace(function()
                local picker = action_state.get_current_picker(prompt_bufnr)
                local multi = picker:get_multi_selection()

                actions.close(prompt_bufnr)

                local selection = action_state.get_selected_entry()

                local cmd = {}

                for _, entry in ipairs(multi) do
                    if entry[1] ~= selection[1] then
                        table.insert(cmd, entry[1])
                    end
                end

                table.insert(cmd, selection[1])

                config.callback(cmd)
            end)

            return true
        end
    }):find()
end

return M
