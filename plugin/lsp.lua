-- mason
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require("mason-lspconfig").setup({
    automatic_enable = true,
    ensure_installed = {
        "vimls",
        "lua_ls",
    }
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = 'lua',
    once = true,
    callback = function()
        vim.cmd("packadd lazydev.nvim")

        -- lazydev
        require("lazydev").setup({
            library = {
                {
                    path = "${3rd}/luv/library",
                    word = { "vim%.uv" }
                }
            }
        })
    end
})
