return {
    "RRethy/vim-illuminate",
    config = function()
        require("illuminate").configure()

        local highlight_group = vim.api.nvim_create_augroup("IlluminatedWordColor", { clear = true })


        vim.api.nvim_set_hl(0, "Visual", { bg = "#2d3f76" })
        vim.api.nvim_set_hl(0, "IlluminatedWordColor", { bg = "#23315c" })

        -- change the highlight style
        vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "IlluminatedWordColor" })
        vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "IlluminatedWordColor" })
        vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "IlluminatedWordColor" })

        --- auto update the highlight style on colorscheme change
        vim.api.nvim_create_autocmd({ "ColorScheme" }, {
            pattern = { "*" },
            callback = function(ev)
                vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "IlluminatedWordColor" })
                vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "IlluminatedWordColor" })
                vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "IlluminatedWordColor" })
            end
        })
    end
}
