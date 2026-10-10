require("nvim-autopairs").setup {}

local theme = require("tokyonight")
theme.setup({
    style = "moon",
    transparent = true,
    terminal_colors = true,
    styles = {
        comments = { italic = false },
        keywords = { italic = false },
        floats = "dark",
        sidebars = "dark",
    },
    on_colors = function() end,
    on_highlights = function() end,
})
vim.cmd [[colorscheme tokyonight]]

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

-- noice
local noice = require("noice")
noice.setup({
    lsp = {
        signature = {
            auto_open = {
                enabled = false
            }
        },
        override = {
            -- override the default lsp markdown formatter with Noice
            ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
            -- override the lsp markdown formatter with Noice
            ["vim.lsp.util.stylize_markdown"] = false,
            -- override cmp documentation with Noice (needs the other options to work)
            ["cmp.entry.get_documentation"] = false,
        }
    }
})
vim.keymap.set("n", "<leader>nc", ":Noice dismiss<CR>", { silent = true })
vim.keymap.set("n", "<leader>na", ":Noice all<CR>", { silent = true })

-- multiple cursor
require("multiple-cursors").setup()
vim.keymap.set({ "n", "x" }, "<C-n>", function() vim.cmd('MultipleCursorsAddDown') end,
    { desc = "Add multiple cursor down" })
vim.keymap.set({ "n", "x" }, "<C-p>", function() vim.cmd('MultipleCursorsAddUp') end, { desc = "Add multiple cursor up" })
vim.keymap.set({ "n", "x" }, "<A-j>", function() vim.cmd('MultipleCursorsAddJumpNextMatch') end,
    { desc = "Select next match" })
vim.keymap.set({ "n", "x" }, "<A-k>", function() vim.cmd('MultipleCursorsAddJumpPrevMatch') end,
    { desc = "Select previous match" })
vim.keymap.set({ "n", "x" }, "<A-x>", function() vim.cmd('MultipleCursorsJumpNextMatch') end,
    { desc = "Add multiple cursor up" })

-- undo tree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, {
    desc = "Undo tree toggle"
})
