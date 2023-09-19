-- ToggleTerm open terminal
vim.keymap.set("n", "<leader>opt", vim.cmd.ToggleTerm, { desc = "Open Terminal" })

-- BufferDelete
vim.keymap.set("n", "<M-w>", vim.cmd.Bdelete, { desc = "Close Buffer" })

-- Bufferline
local Go = {}
Go.tab = function(tabIndex)
    return function()
        vim.cmd("BufferLineGoToBuffer " .. tabIndex)
    end
end
vim.keymap.set("n", '<leader>1', Go.tab(1), { desc = "Go to tab 1" })
vim.keymap.set("n", '<leader>2', Go.tab(2), { desc = "Go to tab 2" })
vim.keymap.set("n", '<leader>3', Go.tab(3), { desc = "Go to tab 3" })
vim.keymap.set("n", '<leader>4', Go.tab(4), { desc = "Go to tab 4" })
vim.keymap.set("n", '<leader>5', Go.tab(5), { desc = "Go to tab 5" })
vim.keymap.set("n","<leader>`",vim.cmd.BufferLinePick, {desc = "Buffer pick tab"})

-- Nvim Tree
local nvimtree = function()
    local api = require("nvim-tree.api")
    local tree = api.tree

    if tree.is_tree_buf() then
        tree.close()
    else
        tree.open()
    end
end
vim.keymap.set("n", "<M-1>", nvimtree, { desc = "NvimTreeToggle" })

-- Split Screen
vim.keymap.set("n", "<leader>sp", vim.cmd.sp, { desc = "[Sp]lit Screen" })
vim.keymap.set("n", "<leader>vsp", vim.cmd.vs, { desc = "[Sp]lit Screen" })
vim.keymap.set("n", "<tab>", vim.cmd.w, { desc = "[Sp]lit Screen" })

-- General Config
vim.keymap.set("n", "<leader>/", vim.cmd.nohlsearch, { desc = "No search highlight" })
vim.keymap.set({ "n", "v" }, "L", "e", { desc = "Next word at end of word" })
vim.keymap.set({ "n", "v" }, "H", "b", { desc = "Back word at start of word" })
vim.keymap.set({ "n", "v" }, "J", "3j", { desc = "Move coursor down 3 line" })
vim.keymap.set({ "n", "v" }, "K", "3k", { desc = "Move coursor up 3 line" })

-- Yank and Paste with key store
vim.keymap.set("n", "<leader>pa", '"ap', { desc = "Paste text store in char a" })
vim.keymap.set("n", "<leader>ps", '"sp', { desc = "Paste text store in char s" })
vim.keymap.set("n", "<leader>pd", '"dp', { desc = "Paste text store in char d" })

vim.keymap.set("v", "<leader>ya", '"ay', { desc = "Yank text in char a" })
vim.keymap.set("v", "<leader>ys", '"sy', { desc = "Yank text in char s" })
vim.keymap.set("v", "<leader>yd", '"dy', { desc = "Yank text in char d" })

-- Telescope
local status_ok, builtin = pcall(require, "telescope.builtin")
if not status_ok then
    return
end
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "[Git files] Find all find in git track" })
vim.keymap.set('n', '<C-f>', builtin.find_files, { desc = "[F]ind [F]iles] Find all in current working directory" })
vim.keymap.set('n', '<leader>lg', builtin.live_grep,
    { desc = "[L]ive [G]rep Search for a string in current working directory" })
vim.keymap.set('n', '<C-e>', builtin.oldfiles, { desc = "Recently Files" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "help_tags" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find all files buffers" })
vim.keymap.set("n", "<leader>jp", builtin.jumplist, { desc = "jumplist" })
vim.keymap.set("n", "<leader>dg", builtin.diagnostics, { desc = "diagnostics" })
vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "lsp_definitions" })
vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "lsp_implementations" })
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "lsp_references" })

-- Easy motion
vim.keymap.set('n',"<leader>jj","<Plug>(easymotion-sn)",{ desc = "Easy motion search n word"})
