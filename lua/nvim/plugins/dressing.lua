return {
    'stevearc/dressing.nvim',
    config = function()
        require("dressing").setup({
            input = {
                enabled = false,
                relative = "editor",
            }
        })
    end
}
