return {
    dir = "~/code/neovim-plug/folding-nvim",
    lazy = false,
    config = function()
        require("folding_nvim").setup()
    end
}
