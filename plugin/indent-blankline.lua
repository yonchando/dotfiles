require("ibl").setup({
    scope = {
        show_start = false,
        show_end = false,
    }
})

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.fillchars:append("lastline:⋅")

