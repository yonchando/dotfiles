local opts = function(tbl)
    return vim.tbl_extend("keep", { noremap = true, silent = true }, tbl)
end

vim.keymap.set("n", "<leader>so", ":so %<CR>")
vim.keymap.set("n", "<A-a>", "ggVG")
vim.keymap.set("n", "<A-1>", ":Exp<CR>", opts({ desc = "Explore" }))


vim.keymap.set("n", "<A-[>", "<C-o>", opts({ desc = "Jump back" }))
vim.keymap.set("n", "<A-]>", "<C-i>", opts({ desc = "Jump forward" }))


vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", 'n', 'nzzzv')
vim.keymap.set("n", 'N', 'Nzzzv')

vim.keymap.set("n", "<leader>-{", "zfi{", opts({ desc = "Create fold in {}" }))
vim.keymap.set("n", "<leader>-(", "zfi)", opts({ desc = "Create fold in ()" }))
vim.keymap.set("n", "<leader>-f", "zfif", opts({ desc = "Create fold in function" }))
vim.keymap.set("v", "<leader>-", "zf", opts({ desc = "Create fold in function" }))
vim.keymap.set("n", "za", "zazz", opts({ desc = "Toggle fold under cursor" }))

vim.keymap.set("n", "<leader>dw", "diW")

vim.keymap.set("n", "<Right>", "<C-w>10<")
vim.keymap.set("n", "<Left>", "<C-w>10>")
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

vim.keymap.set("v", "<leader>ya", '"ay', opts({ desc = "Yank text in char a" }))
vim.keymap.set("v", "<leader>ys", '"sy', opts({ desc = "Yank text in char s" }))
vim.keymap.set("v", "<leader>yd", '"dy', opts({ desc = "Yank text in char d" }))

vim.keymap.set('v', "<C-c>", '"+y', opts({ desc = "Yank text to clipbaord" }))

vim.keymap.set("v", "<A-f>", '"fy/<C-r>f<CR>', opts({ desc = "Search select text" }))

vim.keymap.set("i", "<C-z>", "<C-c>ua", opts({ desc = "Undo back to insert" }))

-- vim dianostic
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts({ desc = "Diagnostic open float" }))

-- Lsp mapping
vim.keymap.set('n', "<leader>lsr", vim.cmd.LspRestart, opts({ desc = "Lsp Restart" }))

vim.keymap.set("n", "<leader>tp", vim.cmd.TSPlaygroundToggle, opts({ desc = "Treesitter playground" }))

-- DB
vim.keymap.set("n", "<A-2>", vim.cmd.DBUIToggle, opts({ desc = "Toggle DBUI" }))
