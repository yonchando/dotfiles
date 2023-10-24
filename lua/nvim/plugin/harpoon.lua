local status, harpoon = pcall(require, "harpoon")

if not status then
    return
end

harpoon.setup({
    menu = {
        width = 120,
        heigh = 80,
    }
})

local _, harpoon_mark = pcall(require, "harpoon.mark")
local _, harpoon_ui = pcall(require, "harpoon.ui")

local opts = function(tbl)
    return vim.tbl_extend("keep", { noremap = true, silent = true }, tbl)
end

vim.keymap.set("n", "<leader>hm", harpoon_mark.add_file, opts({ desc = "[H]arpoon [M]ark" }))
vim.keymap.set("n", "<leader>hc", harpoon_mark.clear_all, opts({ desc = "[H]arpoon [C]lear All" }))
vim.keymap.set("n", "<leader>ho", harpoon_ui.toggle_quick_menu, opts({ desc = "[H]arpoon toggle quick menu ([o]pen)" }))
vim.keymap.set("n", "<M-n>", harpoon_ui.nav_next, opts({ desc = "Harpoon [N]av [N]ext" }))
vim.keymap.set("n", "<M-p>", harpoon_ui.nav_prev, opts({ desc = "Harpoon [N]av [P]rev" }))

vim.api.nvim_set_hl(0, 'HarpoonInactive', { bg = "none", fg = '#63698c' })
vim.api.nvim_set_hl(0, 'HarpoonActive', { bg = "none", fg = 'white' })
vim.api.nvim_set_hl(0, 'HarpoonNumberActive', { bg = "none", fg = '#7aa2f7' })
vim.api.nvim_set_hl(0, 'HarpoonNumberInactive', { bg = "none", fg = '#7aa2f7' })
vim.api.nvim_set_hl(0, 'TabLineFill', { bg = "none", fg = 'red' })
