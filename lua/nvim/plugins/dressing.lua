return {
    'stevearc/dressing.nvim',
    event = "VeryLazy",
    config = function()
        require("dressing").setup({
            input = {
                enabled = false,
                relative = "editor",
            }
        })
    end
}
