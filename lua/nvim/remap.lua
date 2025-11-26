local opts = function(tbl)
    return vim.tbl_extend("keep", { noremap = true, silent = true }, tbl)
end

vim.keymap.set("n", "<leader>x", ":so %<CR>", opts({ desc = "source %" }))
vim.keymap.set("n", "<leader><leader>x", ":so ~/.config/nvim/init.lua<CR>", opts({ desc = "source %" }))
vim.keymap.set("n", "<A-a>", "ggVG")

vim.keymap.set("n", "<A-[>", "<C-o>zz", opts({ desc = "Jump back" }))
vim.keymap.set("n", "<A-]>", "<C-i>zz", opts({ desc = "Jump forward" }))

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", 'n', 'nzzzv')
vim.keymap.set("n", 'N', 'Nzzzv')

vim.keymap.set("n", "<leader>ee", function()
    vim.o.foldmethod = 'manual'
end, opts({ desc = "foldmethod manual" }))

vim.keymap.set("n", "<leader>el1", function()
    vim.o.foldlevel = 0
    vim.o.foldnestmax = 1
    vim.o.foldmethod = 'indent'
end, opts({ desc = "Fold all" }))
vim.keymap.set("n", "<leader>el2", function()
    vim.o.foldlevel = 1
    vim.o.foldnestmax = 1
    vim.o.foldmethod = 'indent'
end, opts({ desc = "Fold level 1" }))
vim.keymap.set("n", "<leader>el3", function()
    vim.o.foldlevel = 2
    vim.o.foldnestmax = 1
    vim.o.foldmethod = 'indent'
end, opts({ desc = "Fold leve 2" }))

vim.keymap.set("n", "<leader>_", "zM")
vim.keymap.set("n", "<leader>+", "zR")
vim.keymap.set("n", "<leader>=", "za")

vim.keymap.set("n", "<leader>dw", "diW")

vim.keymap.set("n", "<Right>", "<C-w>10>")
vim.keymap.set("n", "<Left>", "<C-w>10<")
vim.keymap.set("n", "<Up>", "<C-w>10+")
vim.keymap.set("n", "<Down>", "<C-w>10-")

-- Save
vim.keymap.set({ "n", "i" }, "<C-s>", vim.cmd.wa, opts({ desc = "Save all" }))
vim.keymap.set("n", "<leader>q", vim.cmd.wqa, opts({ desc = "Save all and exit nvim" }))

-- Split Screen
vim.keymap.set("n", "<leader>sp", vim.cmd.sp, opts({ desc = "[Sp]lit Screen" }))
vim.keymap.set("n", "<leader>vsp", vim.cmd.vs, opts({ desc = "[Sp]lit Screen" }))
vim.keymap.set("n", "<leader>z", vim.cmd.only, opts({ desc = "Full on current split screen" }))
vim.keymap.set("n", "<A-x>", "<C-w>c", opts({ desc = "Close split screen" }))

-- General Config
vim.keymap.set("n", "<leader>/", vim.cmd.nohlsearch, opts({ desc = "No search highlight" }))
vim.keymap.set("n", "<leader>?", vim.cmd.NoiceDismiss, opts({ desc = "No search highlight" }))
vim.keymap.set({ "n", "v" }, "L", "e", opts({ desc = "Next word at end of word" }))
vim.keymap.set({ "n", "v" }, "H", "b", opts({ desc = "Back word at start of word" }))
vim.keymap.set({ "n", "v" }, "J", "3jzz", opts({ desc = "Move coursor down 3 line" }))
vim.keymap.set({ "n", "v" }, "K", "3kzz", opts({ desc = "Move coursor up 3 line" }))

-- Yank and Paste with key store
vim.keymap.set({ "n", "v" }, "<leader>pa", '"ap', opts({ desc = "Paste text store in char a" }))
vim.keymap.set({ "n", "v" }, "<leader>ps", '"sp', opts({ desc = "Paste text store in char s" }))
vim.keymap.set({ "n", "v" }, "<leader>pd", '"dp', opts({ desc = "Paste text store in char d" }))
vim.keymap.set({ "n", "v" }, "<leader>pp", '"0pdiwP', opts({ desc = "Paste text store in char d" }))

vim.keymap.set("v", "<leader>ya", '"ay', opts({ desc = "Yank text in char a" }))
vim.keymap.set("v", "<leader>ys", '"sy', opts({ desc = "Yank text in char s" }))
vim.keymap.set("v", "<leader>yd", '"dy', opts({ desc = "Yank text in char d" }))

vim.keymap.set('v', "<C-c>", '"+y', opts({ desc = "Yank text to clipbaord" }))

vim.keymap.set("v", "<A-f>", '"fy/<C-r>f<CR>', opts({ desc = "Search select text" }))

vim.keymap.set("i", "<C-z>", "<C-c>ua", opts({ desc = "Undo back to insert" }))

-- vim dianostic
vim.keymap.set('n', '<leader>E', vim.diagnostic.open_float, opts({ desc = "Diagnostic open float" }))

-- Lsp mapping
vim.keymap.set('n', "<leader>lsr", vim.cmd.LspRestart, opts({ desc = "Lsp Restart" }))
