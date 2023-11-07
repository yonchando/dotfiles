return {
    'nvim-tree/nvim-web-devicons',
    priority = 1000,
    config = function()
        local devicons = require("nvim-web-devicons")

        devicons.setup {
            override = {
                zsh = {
                    icon = "",
                    color = "#428850",
                    cterm_color = "65",
                    name = "Zsh"
                }
            },
            color_icons = true,
            default = true,
            strict = true,
        }
    end
}
