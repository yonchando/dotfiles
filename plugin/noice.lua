local noice = require("noice")

noice.setup({
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = false,
        },
        signature = {
            enabled = false,
        }
    },
})

vim.keymap.set("n", "<leader>nc", ":Noice dismiss<CR>", { silent = true })
