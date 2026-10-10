require('gitsigns').setup {
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal({ ']c', bang = true })
            else
                gitsigns.nav_hunk('next')
            end
        end)

        map('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal({ '[c', bang = true })
            else
                gitsigns.nav_hunk('prev')
            end
        end)

        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk)
        map('n', '<leader>hr', gitsigns.reset_hunk)

        map('v', '<leader>hs', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end)

        map('v', '<leader>hr', function()
            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end)

        map('n', '<leader>hS', gitsigns.stage_buffer)
        map('n', '<leader>hR', gitsigns.reset_buffer)
        map('n', '<leader>hp', gitsigns.preview_hunk)
        map('n', '<leader>hi', gitsigns.preview_hunk_inline)

        map('n', '<leader>hb', function()
            gitsigns.blame_line({ full = true })
        end)

        map('n', '<leader>hd', gitsigns.diffthis)

        map('n', '<leader>hD', function()
            gitsigns.diffthis('~')
        end)

        map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
        map('n', '<leader>hq', gitsigns.setqflist)

        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
        map('n', '<leader>tw', gitsigns.toggle_word_diff)

        -- Text object
        map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
    end
}

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = "Telescope git branches" })
vim.keymap.set('n', '<leader>gt', builtin.git_stash, { desc = "Telescope git stash" })

-- git vim-fugitive and telescope git
vim.keymap.set("n", "<leader>gs", function() vim.cmd('Git') end, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gc", function() vim.cmd('Git commit') end, { desc = "Git Commits" })
vim.keymap.set("n", "<leader>gd", function() vim.cmd('Git diff') end, { desc = "Git diff" })
vim.keymap.set("n", "<leader>gl", function() vim.cmd('Git log --oneline') end, { desc = "Git log" })
vim.keymap.set("n", "<leader>g.", function() vim.cmd('Gclog %') end, { desc = "Git log current file" })
vim.keymap.set("n", "<leader>g1", function() vim.cmd('Gedit :1:%') end, { desc = "Git open base version (stage 1)" })

vim.keymap.set("n", "<leader>gu", function() vim.cmd('diffget //2') end, { desc = "Git diffget ours (left)" })
vim.keymap.set("n", "<leader>gh", function() vim.cmd('diffget //3') end, { desc = "Git diffget theirs (right)" })

vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "*",
    callback = function()
        if vim.bo.filetype ~= "fugitive" then
            return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }

        vim.keymap.set("n", "<leader>gl", function()
            vim.cmd("Git pull --rebase")
        end, opts)
    end
})
