local Job = require("plenary.job")
local ui = require("mvn.ui")
local job = require("mvn.job")

local floats = {}
local M = {}

local params = {
    groupId = "",
    artifactId = "",
    archetypeVersion = ""
}

M.create_projects = function(selection)
    params.groupId = vim.fn.input("Group ID: ", "com.chando");
    params.artifactId = vim.fn.input("Artifact Id: ", "my-app");
    params.archetypeVersion = vim.fn.input("Archettype version: ", "1.5");

    local cwd = vim.fn.getcwd()
    local args = {
        "archetype:generate",
        "-DarchetypeArtifactId=" .. selection[1],
        "-DgroupId=" .. params.groupId,
        "-DartifactId=" .. params.artifactId,
        "-DarchetypeVersion=" .. params.archetypeVersion,
        "-DinteractiveMode=false"
    }

    floats = ui.create_output({
        attach_mappings = function(win, bufnr, map)
            local exit = function()
                local selected = cwd .. params.artifactId

                local state = vim.loop.fs_stat(selected)

                if state == nil then
                    return
                end

                vim.fn.execute("cd " .. params.artifactId, "silent")

                local nvimtree_api_ok, nvimtree_api = pcall(require, "nvim-tree.api")

                if nvimtree_api_ok then
                    nvimtree_api.tree.change_root(selected)
                    nvimtree_api.tree.reload()
                end

                vim.api.nvim_win_close(floats.win, false)
                vim.api.nvim_buf_delete(floats.bufnr, {})
            end
            map("n", "q", exit)
            map("n", "<Esc>", exit)
        end
    })


    job.run(floats, {
        cwd = cwd,
        args = args,
        message_start = "Proejct initial",
        message_finish = "Project initial success"
    })
end

return M
