local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

telescope.setup {
    defaults = {
        layout_config = {
            vertical = { width = 1.5 }
        },
        mappings = {
            i = {
                ["<C-h>"] = "which_key"
            }
        },
        theme = "dropdown"
    },
    pickers = {
        find_files = {
            theme = "dropdown",
            previewer = false,
        },
        git_files = {
            theme = "dropdown",
            previewer = false,
        },
        oldfiles = {
            theme = "dropdown",
            previewer = false,
        },
        artisan_routes = {
            theme = "dropdown",
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
    vim.keymap.set('n', '<C-f>', builtin.find_files, { desc = "[F]ind [F]iles] Find all in current working directory" })

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
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "help_tags" })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find all files buffers" })
    vim.keymap.set("n", "<leader>jp", builtin.jumplist, { desc = "jumplist" })

    vim.keymap.set("n", "<leader>dig", builtin.diagnostics, { desc = "diagnostics" })

    vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "lsp_definitions" })
    vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "lsp_implementations" })
    vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "lsp_references" })

    vim.keymap.set('n', '<leader>fz', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
        })
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git status" })
    vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Git lists commits" })
    vim.keymap.set("n", "<leader>gbc", builtin.git_bcommits, { desc = "Git list current buffer commit" })
end

pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, "ui-select")
pcall(telescope.load_extension, "harpoon")
