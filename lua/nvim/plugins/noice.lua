-- lazy.nvim
return {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = true,
    opts = {},
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function()
        local noice = require("noice")
        noice.setup({
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = false, -- requires hrsh7th/nvim-cmp
                },
            },
            presets = {
                bottom_search = true,         -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false,       -- add a border to hover docs and signature help
            },
        })

        local opts = function(tbl)
            return vim.tbl_extend("keep", { silent = true, noremap = true }, tbl)
        end

        vim.keymap.set("n", "<leader>nc", function()
            noice.cmd("dismiss")
        end, opts({ desc = "Noice dismiss" }))

        vim.keymap.set("n", "<leader>nl", function()
            noice.cmd("last")
        end, opts({ desc = "Noice last" }))

        vim.keymap.set("n", "<leader>nh", function()
            noice.cmd("dismiss")
        end, opts({ desc = "Noice history" }))

        vim.keymap.set("n", "<leader>na", function()
            noice.cmd("all")
        end, opts({ desc = "Noice all" }))
    end
}
