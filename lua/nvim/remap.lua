local opts = function(tbl)
    return vim.tbl_extend("keep", { noremap = true, silent = true }, tbl)
end

vim.keymap.set("n", "<A-a>", "ggVG")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", 'n', 'nzzzv')
vim.keymap.set("n", 'N', 'Nzzzv')

vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")

vim.keymap.set("n", "<leader>--", "zfi{")
vim.keymap.set("v", "<leader>-", "zf")
vim.keymap.set("n", "<leader>=", "za")

-- Save
vim.keymap.set("n", "<c-s>", vim.cmd.wa, opts({ desc = "Save all" }))
vim.keymap.set("n", "<leader>q", vim.cmd.wqa, opts({ desc = "Save all and exit nvim" }))

-- Split Screen
vim.keymap.set("n", "<leader>sp", vim.cmd.sp, opts({ desc = "[Sp]lit Screen" }))
vim.keymap.set("n", "<leader>vsp", vim.cmd.vs, opts({ desc = "[Sp]lit Screen" }))
vim.keymap.set("n", "<leader>z", vim.cmd.only, opts({ desc = "Full on current split screen" }))
vim.keymap.set("n", "<leader>x", "<C-w>c", opts({ desc = "Close split screen" }))

-- General Config
vim.keymap.set("n", "<leader>/", vim.cmd.nohlsearch, opts({ desc = "No search highlight" }))
vim.keymap.set({ "n", "v" }, "L", "e", opts({ desc = "Next word at end of word" }))
vim.keymap.set({ "n", "v" }, "H", "b", opts({ desc = "Back word at start of word" }))
vim.keymap.set({ "n", "v" }, "J", "3jzz", opts({ desc = "Move coursor down 3 line" }))
vim.keymap.set({ "n", "v" }, "K", "3kzz", opts({ desc = "Move coursor up 3 line" }))

-- Yank and Paste with key store
vim.keymap.set({ "n", "v" }, "<leader>pa", '"ap', opts({ desc = "Paste text store in char a" }))
vim.keymap.set({ "n", "v" }, "<leader>ps", '"sp', opts({ desc = "Paste text store in char s" }))
vim.keymap.set({ "n", "v" }, "<leader>pd", '"dp', opts({ desc = "Paste text store in char d" }))

vim.keymap.set("v", "<leader>ya", '"ay', opts({ desc = "Yank text in char a" }))
vim.keymap.set("v", "<leader>ys", '"sy', opts({ desc = "Yank text in char s" }))
vim.keymap.set("v", "<leader>yd", '"dy', opts({ desc = "Yank text in char d" }))

vim.keymap.set('v', "<C-c>", '"+y', opts({ desc = "Yank text to clipbaord" }))

-- vim dianostic
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts({ desc = "Diagnostic open float" }))
vim.keymap.set('n', '<leader>din', vim.diagnostic.goto_prev, opts({ desc = "Go to prev Diagnostic" }))
vim.keymap.set('n', '<leader>dip', vim.diagnostic.goto_next, opts({ desc = "Go to next Diagnostic" }))

-- Lsp mapping
vim.keymap.set('n', "<leader>lsr", vim.cmd.LspRestart, opts({ desc = "Lsp Restart" }))

vim.keymap.set("n", "<leader>tsp", vim.cmd.TSPlaygroundToggle, opts({ desc = "Treesitter playground" }))
