local autopairs = require("nvim-autopairs")

autopairs.setup {}

-- indent blankline
require("ibl").setup({
    scope = {
        show_start = false,
        show_end = false,
    }
})
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.fillchars:append("lastline:⋅")

-- multiple cursor
require("multiple-cursors").setup({
    pre_hook = function()
        autopairs.disable()
    end,
    post_hook = function()
        autopairs.enable()
    end
})

local keys = {
    { keymap = "<C-n>",     cmd = function() vim.cmd("MultipleCursorsAddDown") end,          desc = "MultipleCursor: Add multiple cursor down" },
    { keymap = "<C-p>",     cmd = function() vim.cmd("MultipleCursorsAddUp") end,            desc = "MultipleCursor: Add multiple cursor up" },
    { keymap = "<A-j>",     cmd = function() vim.cmd("MultipleCursorsAddJumpNextMatch") end, desc = "MultipleCursor: Select next match" },
    { keymap = "<A-k>",     cmd = function() vim.cmd("MultipleCursorsAddJumpPrevMatch") end, desc = "MultipleCursor: Select previous match" },
    { keymap = "<A-x>",     cmd = function() vim.cmd("MultipleCursorsJumpNextMatch") end,    desc = "MultipleCursor: Skip current line" },
    { keymap = "<A-d>",     cmd = function() vim.cmd("MultipleCursorsAddDelete") end,        desc = "MultipleCursor: Add or delete on locked cursor" },
    { keymap = "<leader>a", cmd = function() vim.cmd("MultipleCursorsAddMatches") end,       desc = "MultipleCursor: Select all match under cursor" },
    { keymap = "<A-l>",     cmd = function() vim.cmd("MultipleCursorsLock") end,             desc = "MultipleCursor: " },
}

for _, value in pairs(keys) do
    local mode = value.mode or { "n", "x" }
    vim.keymap.set(mode, value.keymap, value.cmd, { desc = value.desc })
end

-- undo tree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, {
    desc = "Undo tree toggle"
})
