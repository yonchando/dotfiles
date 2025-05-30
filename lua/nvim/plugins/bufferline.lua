return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        local bufferline = require("bufferline")

        vim.opt.termguicolors = true

        bufferline.setup {
            options = {
                mode = "buffers",
                style_preset = bufferline.style_preset.minimal,
                themable = false,
                numbers = function(num)
                    return num.ordinal .. "(" .. num.id .. ")"
                end,
                indicator = {
                    style = "none"
                },
                modified_icon = '*',
                max_name_length = 18,
                tab_size = 18
            }
        }

        local opts = function(tbl)
            return vim.tbl_extend("keep", { noremap = true, silent = true }, tbl)
        end
        -- Bufferline
        local goTo = {}
        goTo.tab = function(tabIndex)
            return function()
                bufferline.go_to(tabIndex, true)
            end
        end
        -- BufferDelete
        vim.keymap.set("n", "<A-w>", vim.cmd.Bdelete, opts({ desc = "Close Buffer" }))
        vim.keymap.set("n", "<A-b>", vim.cmd.close, opts({ desc = "Close Buffer" }))
        vim.keymap.set("n", "<leader>cb", vim.cmd.Bdelete, opts({ desc = "Close Current Buffer" }))
        vim.keymap.set("n", "<leader>cl", vim.cmd.BufferLineCloseLeft, opts({ desc = "Close all left buffer" }))
        vim.keymap.set("n", "<leader>cr", vim.cmd.BufferLineCloseRight, opts({ desc = "Close all right buffer" }))
        vim.keymap.set("n", "<leader>co", vim.cmd.BufferLineCloseOthers, opts({ desc = "Close others" }))

        vim.keymap.set("n", "[t", vim.cmd.BufferLineMovePrev, opts({ desc = "Close others" }))
        vim.keymap.set("n", "]t", vim.cmd.BufferLineMoveNext, opts({ desc = "Close others" }))

        vim.keymap.set("n", "<Tab>", vim.cmd.BufferLineCycleNext, opts({ desc = "Close others" }))
        vim.keymap.set("n", "<S-Tab>", vim.cmd.BufferLineCyclePrev, opts({ desc = "Close others" }))

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
}
