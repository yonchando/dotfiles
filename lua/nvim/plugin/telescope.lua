local builtin = require('telescope.builtin')

local hiddenFiles = function()
    builtin.find_files({hideen = true})
end

vim.keymap.set('n', '<C-p>', builtin.git_files, {desc = "[Git files] Find all find in git track"})
vim.keymap.set('n', '<C-f>', builtin.find_files, {desc = "[F]ind [F]iles] Find all in current working directory"})
vim.keymap.set('n', '<c-f>lg', builtin.live_grep,{desc = "Live [G]rep Search for a string in current working directory"})
vim.keymap.set('n', '<C-e>', builtin.oldfiles,{desc = "Recently Files"})
vim.keymap.set('n', '<leader>fh', hiddenFiles,{desc = "Find all files include hidden file."})


local telescope = require('telescope')

telescope.setup{
    defaults = {

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
        }
    },
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }
}

telescope.load_extension('fzf')
