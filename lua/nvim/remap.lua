-- BufferDelete
vim.keymap.set("n", "<M-w>", vim.cmd.Bdelete, { desc = "Close Buffer" })
vim.keymap.set("n", "<leader>cb", vim.cmd.Bdelete, { desc = "Close Current Buffer" })
vim.keymap.set("n", "<leader>cl", vim.cmd.BufferLineCloseLeft, { desc = "Close all left buffer" })
vim.keymap.set("n", "<leader>cr", vim.cmd.BufferLineCloseRight, { desc = "Close all right buffer" })
vim.keymap.set("n", "<leader>co", vim.cmd.BufferLineCloseOthers, { desc = "Close others" })

-- Bufferline
local goTo = {}
goTo.tab = function(tabIndex)
    return function()
        vim.cmd("BufferLineGoToBuffer " .. tabIndex)
    end
end
vim.keymap.set("n", '<leader>1', goTo.tab(1), { desc = "Go to tab 1" })
vim.keymap.set("n", '<leader>2', goTo.tab(2), { desc = "Go to tab 2" })
vim.keymap.set("n", '<leader>3', goTo.tab(3), { desc = "Go to tab 3" })
vim.keymap.set("n", '<leader>4', goTo.tab(4), { desc = "Go to tab 4" })
vim.keymap.set("n", '<leader>5', goTo.tab(5), { desc = "Go to tab 5" })
vim.keymap.set("n", "<leader>`", vim.cmd.BufferLinePick, { desc = "Buffer pick tab" })

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
vim.keymap.set("n", "<leader><tab>", nvimtree, { desc = "NvimTreeToggle" })

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
if status_ok then
    vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "[Git files] Find all find in git track" })
    vim.keymap.set('n', '<C-f>', builtin.find_files, { desc = "[F]ind [F]iles] Find all in current working directory" })

    vim.keymap.set('n', '<leader>ff', function()
        return builtin.find_files({ hidden = true })
    end, {
        desc = "[F]ind [F]iles] Find all in current working directory"
    })

    vim.keymap.set('n', '<leader>lg', builtin.live_grep, {
        desc = "[L]ive [G]rep Search for a string in current working directory"
    })
    vim.keymap.set('n', '<C-e>', builtin.oldfiles, { desc = "Recently Files" })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "help_tags" })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find all files buffers" })
    vim.keymap.set("n", "<leader>jp", builtin.jumplist, { desc = "jumplist" })

    vim.keymap.set("n", "<leader>dig", builtin.diagnostics, { desc = "diagnostics" })

    vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "lsp_definitions" })
    vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "lsp_implementations" })
    vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "lsp_references" })
end

-- vim dianostic
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = "Diagnostic open float" })
vim.keymap.set('n', '<leader>din', vim.diagnostic.goto_prev, { desc = "Go to prev Diagnostic" })
vim.keymap.set('n', '<leader>dip', vim.diagnostic.goto_next, { desc = "Go to next Diagnostic" })

-- Easy motion
vim.keymap.set('n', "<leader>jj", "<Plug>(easymotion-sn)", { desc = "Easy motion search n word" })


local luasnip_status, ls = pcall(require, "luasnip")
if luasnip_status then
    vim.keymap.set({ "i" }, "<C-j>", function() ls.expand() end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-N>", function() ls.jump(1) end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-N>", function() ls.jump(-1) end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<C-<space>>", function()
        if ls.choice_active() then
            ls.change_choice(1)
        end
    end, { silent = true })
end
