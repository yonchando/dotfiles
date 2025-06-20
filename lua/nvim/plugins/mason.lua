return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        automatic_enable = false,
        ensure_installed = { "lua_ls", "bashls" },
    },
    dependencies = {
        {
            "mason-org/mason.nvim",
            opts = {
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            }
        },
        "neovim/nvim-lspconfig",
    },
}
