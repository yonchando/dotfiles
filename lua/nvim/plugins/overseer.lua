return {
    'stevearc/overseer.nvim',
    opts = {},
    config = function()
        require("overseer").setup({
            templates = { "builtin", "user.go_run" }
        })
    end
}
