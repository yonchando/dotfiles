return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<C-f>', builtin.find_files, { desc = "Telescope find files" })
        vim.keymap.set('n', '<leader>ff', function()
            builtin.find_files({
                hidden = true,
                no_ignore = true,
            })
        end, { desc = 'Telescope find all files include hidden and git ignore' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

        vim.keymap.set("n", "<leader>dd", builtin.diagnostics, { desc = "Diagnostics" })

        vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Lsp Definitions" })
        vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "Lsp Implementations" })
        vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Lsp References" })
        vim.keymap.set("n", "gm", builtin.lsp_document_symbols, { desc = "Lsp Document Symbols" })

        vim.keymap.set('n', '<C-e>', function()
            return builtin.oldfiles({ cwd_only = true })
        end, { desc = "Recently Files" })
    end
}
