local theme = require("tokyonight")

theme.setup({
    style = "moon",
    transparent = true,
    terminal_colors = true,
    styles = {
        comments = { italic = true },
        keywords = { italic = true },
        floats = "dark",
    }
})


vim.cmd[[colorscheme tokyonight]]
