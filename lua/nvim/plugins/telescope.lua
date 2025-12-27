return {
    'nvim-telescope/telescope.nvim',
    version = '1.*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        "nvim-telescope/telescope-ui-select.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        "folke/noice.nvim",
    },
    config = function()
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
                fzf = {},
                noice = {},
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown()
                }
            }
        })
        -- telescope.load_extension("noice")
        telescope.load_extension("fzf")
        telescope.load_extension("ui-select")

        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<A-f>', function()
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = '[/] Fuzzily search in current buffer' })

        vim.keymap.set('n', "<A-7>", builtin.treesitter, { desc = 'Telescope tree' })

        vim.keymap.set('n', '<C-f>', builtin.find_files, { desc = "Telescope find files" })
        vim.keymap.set('n', '<C-p>', function()
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
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Lsp References" })
        vim.keymap.set("n", "gm", builtin.lsp_document_symbols, { desc = "Lsp Document Symbols" })

        vim.keymap.set("n", "<A-9>", builtin.git_branches, { desc = "Git list branches" })
        vim.keymap.set("n", "<A-0>", builtin.git_bcommits, { desc = "Git commit history current buffer" })
        vim.keymap.set("n", "<A-k>", builtin.git_commits, { desc = "Git commit history all" })

        vim.keymap.set('n', '<C-e>', function()
            return builtin.oldfiles({ cwd_only = true })
        end, { desc = "Recently Files" })
    end
}
