return {
    dir = "~/code/lua/java-init-project.nvim",
    enabled = false,
    config = function()
        require("java_project_init").setup()
    end
}
