return {
    'nvim-telescope/telescope.nvim',
    version = '0.1.4',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        "nvim-telescope/telescope-ui-select.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        local status_ok, telescope = pcall(require, "telescope")
        if not status_ok then
            return
        end

        telescope.setup {
            defaults = {
                layout_config = {
                    height = 0.90,
                },
                mappings = {
                    i = {
                        ["<C-h>"] = "which_key"
                    }
                },
            },
            pickers = {
                find_files = {
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
                }
            },
            extensions = {
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown()
                }
            }
        }

        -- Telescope
        local builtin_status, builtin = pcall(require, "telescope.builtin")

        if builtin_status then
            vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "[Git files] Find all find in git track" })
            vim.keymap.set('n', '<C-f>', builtin.find_files,
                { desc = "[F]ind [F]iles] Find all in current working directory" })

            vim.keymap.set('n', '<leader>ff', function()
                return builtin.find_files({ hidden = true, no_ignore = true })
            end, {
                desc = "[F]ind [F]iles] Find all in current working directory"
            })

            vim.keymap.set('n', '<leader>lg', builtin.live_grep, {
                desc = "[L]ive [G]rep Search for a string in current working directory"
            })

            vim.keymap.set('n', '<C-e>', function()
                return builtin.oldfiles({ cwd_only = true })
            end, { desc = "Recently Files" })

            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help Tags" })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find all files buffers" })
            vim.keymap.set("n", "<leader>jp", builtin.jumplist, { desc = "Jump List" })

            vim.keymap.set("n", "<leader>dig", builtin.diagnostics, { desc = "Diagnostics" })

            vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Lsp Definitions" })
            vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "Lsp Implementations" })
            vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Lsp References" })
            vim.keymap.set("n", "gm", builtin.lsp_document_symbols, { desc = "Lsp Document Symbols" })

            vim.keymap.set('n', '<A-f>', function()
                require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })

            vim.keymap.set('n', "<A-7>", builtin.treesitter, { desc = "Treesitter" })
        end

        pcall(telescope.load_extension, 'fzf')
        pcall(telescope.load_extension, "ui-select")
        pcall(telescope.load_extension, "harpoon")
        pcall(telescope.load_extension, "noice")
    end
}
