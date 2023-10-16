local status_ok, gitsigns = pcall(require, 'gitsigns')

if not status_ok then
    return
end

gitsigns.setup {
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end
        -- Navigation
        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true, desc = "Gitsigns next_hunk" })

        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true, desc = "Gitsigns prev_hunk" })

        -- Actions
        map('n', '<leader>hp', gs.preview_hunk, { desc = "preview_hunk" })
        map('n', "<leader>hd", gs.diffthis, { desc = "Git diff this" })
        map('n', '<leader>hs', gs.stage_hunk, { desc = "stage_hunk" })
        map('n', '<leader>hr', gs.reset_hunk, { desc = "reset_hunk" })
        map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
            { desc = "stage_hunk" })
        map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
            { desc = "reset_hunk" })

        map('n', '<leader>hS', gs.stage_buffer, { desc = "stage_buffer" })
        map('n', '<leader>hR', gs.reset_buffer, { desc = "reset_buffer" })

        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "undo_stage_hunk" })

        map('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = "Gitsigns blame_line" })

        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "toggle_current_line_blame" })
        map('n', '<leader>hd', gs.diffthis, { desc = "Gitsigns diff this" })
        map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "Gitsigns diff this ~" })
        map('n', '<leader>td', gs.toggle_deleted, { desc = "Gitsigns toggle_deleted" })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Gitsigns select_hunk" })
    end
}
