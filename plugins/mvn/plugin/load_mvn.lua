local reload = function()
    -- package.loaded["mvn"] = nil
    -- package.loaded["mvn.ui"] = nil
end

vim.api.nvim_create_user_command("MavenCLI", function()
    reload()
    local mvn = require("mvn")
    mvn.mvn_cli(require("telescope.themes").get_dropdown({}))
end, {})

vim.api.nvim_create_user_command("MavenNewProject", function()
    reload()
    local mvn = require("mvn")
    mvn.mvn_create_project(require("telescope.themes").get_dropdown({}))
end, {})
