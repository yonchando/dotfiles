local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
    pickers = {
        find_files = {
            themes = 'ivy',
            previewer = false,
        },
        git_files = {
            previewer = false,
        },
        oldfiles = {
            previewer = false,
        },
        artisan_routes = {
            previewer = false,
        },
        help_tags = {
            themes = 'ivy',
            mappings = {
                i = {
                    ["<CR>"] = function()
                        actions.select_vertical()
                    end
                },
            },
        }
    },
    extension = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
        },
    }
})

require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')

local findAll = function()
    builtin.find_files({
        hidden = true,
        no_ignore = true,
    })
end

local recentlyFiles = function()
    builtin.oldfiles({ cwd_only = true })
end

vim.keymap.set('n', '<C-f>', builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set('n', '<C-p>', findAll, { desc = 'Telescope find all files include hidden and git ignore' })
vim.keymap.set('n', '<C-e>', recentlyFiles, { desc = "Recently Files" })

vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set("n", "<leader>dd", builtin.diagnostics, { desc = "Diagnostics" })

vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Lsp Definitions" })
vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "Lsp Implementations" })
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Lsp References" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Lsp References" })
vim.keymap.set("n", "gm", builtin.lsp_document_symbols, { desc = "Lsp Document Symbols" })


