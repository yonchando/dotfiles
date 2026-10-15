-- noice
local noice = require("noice")
noice.setup({
    lsp = {
        signature = {
            auto_open = {
                enabled = false
            }
        },
        override = {
            -- override the default lsp markdown formatter with Noice
            ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
            -- override the lsp markdown formatter with Noice
            ["vim.lsp.util.stylize_markdown"] = false,
            -- override cmp documentation with Noice (needs the other options to work)
            ["cmp.entry.get_documentation"] = false,
        }
    }
})
vim.keymap.set("n", "<leader>nc", ":Noice dismiss<CR>", { silent = true })
vim.keymap.set("n", "<leader>na", ":Noice all<CR>", { silent = true })
