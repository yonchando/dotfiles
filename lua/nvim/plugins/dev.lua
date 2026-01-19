return {
    {
        dir = "~/.config/nvim/plugins/mvn",
        cond = function()
            local mvn = vim.uv.fs_stat(vim.env.HOME .. "/plugins/mvn")

            return mvn ~= nil
        end,
        config = function()
            require("mvn")
        end
    }
}
