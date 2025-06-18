return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n','<C-f>', builtin.find_files, {desc = "Telescope find files" })
        vim.keymap.set('n', '<leader>ff', function()
            builtin.find_files({
                hidden = true,
                no_ignore = true,
            })
        end, { desc = 'Telescope find all files include hidden and git ignore' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end
}
