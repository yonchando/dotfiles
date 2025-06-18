return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
            'saghen/blink.cmp',
            {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
              library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
              },
            },
          },
        },
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            vim.lsp.config('*',{
                capabilities = capabilities
            })
        end
    }

}
