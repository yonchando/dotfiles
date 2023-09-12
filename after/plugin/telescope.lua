local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', builtin.git_files, {desc = "[Git files] Find all find in git track"})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = "[F]ind [F]iles] Find all in current working directory"})
vim.keymap.set('n', '<leader>fg', builtin.live_grep,{desc = "Live [G]rep Search for a string in current working directory"})
vim.keymap.set('n', '<C-e>', builtin.oldfiles,{desc = "Recently Files"})
vim.keymap.set('n', '<leader>jl', builtin.jumplist,{desc = "[J]ump [L]ist"})


require('telescope').setup{
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
}
