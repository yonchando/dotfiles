return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        local nvim_tree = require("nvim-tree")
        nvim_tree.setup()

        vim.keymap.set("n", "<A-1>", ":NvimTreeToggle<CR>", {silent = true, desc = "Open explorer"})
    end
}
