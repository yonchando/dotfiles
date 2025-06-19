return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        automatic_enable = false
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
    config = function()
        require("mason-lspconfig").setup()
    end
}
