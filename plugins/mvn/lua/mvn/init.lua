local pickers = require("mvn.pickers")
local ui = require("mvn.ui")
local mvn_command = require("mvn.mvn_command")
local mvn_archetype = require("mvn.mvn_archetype")

local floats = {
    bufnr = -1,
    win = -1
}

---@type Job|nil
CurrentJob = nil

local M = {}

M.mvn_cli = function(opts)
    pickers.pickers_menu({
        title = "Maven ClI",
        listing = {
            "clean",
            "compile",
            "package",
            "verify",
            "validate",
            "test",
            "site",
            "deploy",
            "install",
            "exec:java"
        },
        mapping = function(map, actions)
            map("n", "<space>", actions.toggle_selection)
            map("i", "<Tab>", actions.toggle_selection)
        end,
        callback = function(selection)
            local cwd = vim.fn.getcwd()
            floats = ui.create_output({})

            if vim.fn.filereadable(cwd .. "/pom.xml") then
                mvn_command.run_maven(selection, floats.bufnr, cwd)
            else
                vim.api.nvim_buf_set_lines(floats.bufnr, 0, -1, false, { "pom.xml not found!" })
            end
        end
    }, opts)
end

M.mvn_create_project = function(opts)
    pickers.pickers_menu({
        title = "Maven create project",
        listing = {
            "maven-archetype-simple",
            "maven-archetype-quickstart",
            "maven-archetype-webapp",
            "maven-archetype-portlet",
            "maven-archetype-plugin",
            "maven-archetype-plugin-site",
            "maven-archetype-site",
            "maven-archetype-site-simple",
            "maven-archetype-site-skin",
            "maven-archetype-j2ee-simple",
        },
        callback = function(selection)
            mvn_archetype.create_projects(selection)
        end
    }, opts)
end

return M
