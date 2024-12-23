return {
    "folke/neodev.nvim",
    config = function()
        require("neodev").setup({
            library = {
                plugins = {
                    "nvim-dap-ui",
                    "neotest"
                },
                types = true
            }
        })
    end
}
