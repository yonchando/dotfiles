require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()

local lsn = require("luasnip")

lsn.filetype_extend("htmlangular", { "html" })

vim.keymap.set({ "i" }, "<C-K>", function() lsn.expand() end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function() lsn.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function() lsn.jump(-1) end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
    if lsn.choice_active() then
        lsn.change_choice(1)
    end
end, { silent = true })
