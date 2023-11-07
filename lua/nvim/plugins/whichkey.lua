return {
    "folke/which-key.nvim",
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
        require("which-key").setup {
            window = {
                border = "single"
            },
            operators = {
                gc = "Comments"
            },
            motions = {
                count = true,
            },
            popup_mappings = {
                scroll_down = "<c-d>",
                scroll_up = "<c-u>",
            },
            triggers_blacklist = {
                i = { "<" },
                n = { "d", "c" }
            }
        }
    end
}
