return {
    "folke/flash.nvim",
    config = function()
        local flash = require("flash")
        local opts = function(tbl)
            return vim.tbl_extend("keep", { noremap = true, silent = true }, tbl)
        end
        flash.setup();
        vim.keymap.set({ "n", "x", "o" }, "<leader>jj", flash.jump, opts({ desc = "Flash" }));
        vim.keymap.set({ "n", "x", "o" }, "<leader>jt", flash.treesitter, opts({ desc = "Flash treesitter" }));
        vim.keymap.set({ "c" }, "<C-t>", flash.toggle, opts({ desc = "Flash" }));
    end
}
