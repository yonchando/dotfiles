local theme = require("tokyonight")
theme.setup({
    style = "moon",
    transparent = true,
    terminal_colors = true,
    styles = {
        comments = { italic = false },
        keywords = { italic = false },
        floats = "dark",
        sidebars = "dark",
    },
    on_colors = function() end,
    on_highlights = function() end,
})

local function my_colors()
    local hl = vim.api.nvim_set_hl
    -- Selection
    hl(0, "Visual", { bg = "#264f78" })
    -- Comments
    hl(0, "Comment", { fg = "#8b98a5", italic = true })
    hl(0, "@comment", { link = "Comment" })
    -- Unused variable / function (LSP)
    hl(0, "DiagnosticUnnecessary", { fg = "#6b7680" })
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = my_colors })
vim.cmd.colorscheme("tokyonight")
my_colors()
