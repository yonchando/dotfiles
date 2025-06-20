return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        local bufferline = require("bufferline")

        vim.opt.termguicolors = true

        bufferline.setup({
            options = {
                mode = 'buffers',
                style_preset = bufferline.style_preset.minimal,
                numbers = 'ordinal',
                indicator = {
                    style = 'none'
                },
                modified_icon = '*',
                diagnostics = 'nvim_lsp',
                diagnostics_update_on_event = true,
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    if level == 'error' then
                        return "e"
                    end
                    return ""
                end,
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_alisgn = "center",
                        separator = true
                    }
                }
            }
        })

        local opts = function(tbl)
            return vim.tbl_extend("keep", { noremap = true, silent = true }, tbl)
        end
        local tab = function(tabIndex)
            return function()
                bufferline.go_to(tabIndex, true)
            end
        end
        vim.keymap.set("n", "<A-w>", vim.cmd.Bdelete, opts({ desc = "Bdelete" }))
        vim.keymap.set("n", "<A-b>", vim.cmd.close, opts({ desc = "Vim Close" }))
        vim.keymap.set("n", "<leader>cl", vim.cmd.BufferLineCloseLeft, opts({ desc = "Close all left buffer" }))
        vim.keymap.set("n", "<leader>cr", vim.cmd.BufferLineCloseRight, opts({ desc = "Close all right buffer" }))
        vim.keymap.set("n", "<leader>co", vim.cmd.BufferLineCloseOthers, opts({ desc = "Close others" }))

        vim.keymap.set("n", "[t", vim.cmd.BufferLineMovePrev, opts({ desc = "Close others" }))
        vim.keymap.set("n", "]t", vim.cmd.BufferLineMoveNext, opts({ desc = "Close others" }))

        vim.keymap.set("n", "<Tab>", vim.cmd.BufferLineCycleNext, opts({ desc = "Close others" }))
        vim.keymap.set("n", "<S-Tab>", vim.cmd.BufferLineCyclePrev, opts({ desc = "Close others" }))

        vim.keymap.set("n", '<leader>1', tab(1), opts({ desc = "Go to tab 1" }))
        vim.keymap.set("n", '<leader>2', tab(2), opts({ desc = "Go to tab 2" }))
        vim.keymap.set("n", '<leader>3', tab(3), opts({ desc = "Go to tab 3" }))
        vim.keymap.set("n", '<leader>4', tab(4), opts({ desc = "Go to tab 4" }))
        vim.keymap.set("n", '<leader>5', tab(5), opts({ desc = "Go to tab 5" }))
        vim.keymap.set("n", '<leader>6', tab(6), opts({ desc = "Go to tab 6" }))
        vim.keymap.set("n", '<leader>7', tab(7), opts({ desc = "Go to tab 7" }))
        vim.keymap.set("n", '<leader>8', tab(8), opts({ desc = "Go to tab 8" }))
        vim.keymap.set("n", '<leader>9', tab(9), opts({ desc = "Go to tab 9" }))
        vim.keymap.set("n", '<leader>$', tab(-1), opts({ desc = "Go to tab last" }))
        vim.keymap.set("n", "<leader>`", vim.cmd.BufferLinePick, opts({ desc = "Buffer pick tab" }))
    end
}
