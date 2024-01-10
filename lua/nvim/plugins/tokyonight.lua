return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        require('tokyonight').setup({
            style = "moon",
            transparent = true,
            terminal_colors = true,
            styles = {
                comments = { italic = true },
                keywords = { italic = true },
                floats = "dark",
            }
        })

        vim.cmd [[colorscheme tokyonight]]
    end
}
