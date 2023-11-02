local opts = function(tbl)
    return vim.tbl_extend("keep", { noremap = true, silent = true }, tbl)
end
-- Save
vim.keymap.set("n", "<c-s>", vim.cmd.wa, opts({ desc = "Save all" }))
vim.keymap.set("n", "<leader>q", vim.cmd.wqa, opts({ desc = "Save all and exit nvim" }))

local status, bufferline = pcall(require, "bufferline")

if status then
    -- Bufferline
    local goTo = {}
    goTo.tab = function(tabIndex)
        return function()
            bufferline.go_to(tabIndex, true)
        end
    end
    -- BufferDelete
    vim.keymap.set("n", "<M-w>", vim.cmd.Bdelete, opts({ desc = "Close Buffer" }))
    vim.keymap.set("n", "<leader>cb", vim.cmd.Bdelete, opts({ desc = "Close Current Buffer" }))
    vim.keymap.set("n", "<leader>cl", vim.cmd.BufferLineCloseLeft, opts({ desc = "Close all left buffer" }))
    vim.keymap.set("n", "<leader>cr", vim.cmd.BufferLineCloseRight, opts({ desc = "Close all right buffer" }))
    vim.keymap.set("n", "<leader>co", vim.cmd.BufferLineCloseOthers, opts({ desc = "Close others" }))

    vim.keymap.set("n", '<leader>1', goTo.tab(1), opts({ desc = "Go to tab 1" }))
    vim.keymap.set("n", '<leader>2', goTo.tab(2), opts({ desc = "Go to tab 2" }))
    vim.keymap.set("n", '<leader>3', goTo.tab(3), opts({ desc = "Go to tab 3" }))
    vim.keymap.set("n", '<leader>4', goTo.tab(4), opts({ desc = "Go to tab 4" }))
    vim.keymap.set("n", '<leader>5', goTo.tab(5), opts({ desc = "Go to tab 5" }))
    vim.keymap.set("n", '<leader>6', goTo.tab(6), opts({ desc = "Go to tab 6" }))
    vim.keymap.set("n", '<leader>7', goTo.tab(7), opts({ desc = "Go to tab 7" }))
    vim.keymap.set("n", '<leader>8', goTo.tab(8), opts({ desc = "Go to tab 8" }))
    vim.keymap.set("n", '<leader>9', goTo.tab(9), opts({ desc = "Go to tab 9" }))
    vim.keymap.set("n", '<leader>$', goTo.tab(-1), opts({ desc = "Go to tab last" }))
    vim.keymap.set("n", "<leader>`", vim.cmd.BufferLinePick, opts({ desc = "Buffer pick tab" }))
end

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
vim.keymap.set("n", "<M-1>", nvimtree, opts({ desc = "NvimTreeToggle" }))
vim.keymap.set("n", "<leader><tab>", nvimtree, opts({ desc = "NvimTreeToggle" }))

-- Split Screen
vim.keymap.set("n", "<leader>sp", vim.cmd.sp, opts({ desc = "[Sp]lit Screen" }))
vim.keymap.set("n", "<leader>vsp", vim.cmd.vs, opts({ desc = "[Sp]lit Screen" }))
vim.keymap.set("n", "<leader>z", vim.cmd.only, opts({ desc = "Full on current split screen" }))

-- General Config
vim.keymap.set("n", "<leader>/", vim.cmd.nohlsearch, opts({ desc = "No search highlight" }))
vim.keymap.set({ "n", "v" }, "L", "e", opts({ desc = "Next word at end of word" }))
vim.keymap.set({ "n", "v" }, "H", "b", opts({ desc = "Back word at start of word" }))
vim.keymap.set({ "n", "v" }, "J", "3j", opts({ desc = "Move coursor down 3 line" }))
vim.keymap.set({ "n", "v" }, "K", "3k", opts({ desc = "Move coursor up 3 line" }))

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

-- Codeium
vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true })
vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
vim.keymap.set('i', '<c-\\>', function() return vim.fn['codeium#Complete']() end, { expr = true })
