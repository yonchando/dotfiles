local status, harpoon = pcall(require, "harpoon")

if not status then
    return
end

harpoon.setup()

local _, harpoon_mark = pcall(require, "harpoon.mark")
local _, harpoon_ui = pcall(require, "harpoon.ui")

vim.keymap.set("n", "<leader>hm", harpoon_mark.add_file, { desc = "[H]arpoon [M]ark" })
vim.keymap.set("n", "<leader>hc", harpoon_mark.clear_all, { desc = "[H]arpoon [C]lear All" })
vim.keymap.set("n", "<leader>ho", harpoon_ui.toggle_quick_menu, { desc = "[H]arpoon toggle quick menu ([o]pen)" })
vim.keymap.set("n", "<leader>n", harpoon_ui.nav_next, { desc = "Harpoon [N]av [N]ext" })

vim.cmd('highlight! HarpoonInactive guibg=NONE guifg=#63698c')
vim.cmd('highlight! HarpoonActive guibg=NONE guifg=white')
vim.cmd('highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7')
vim.cmd('highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7')
vim.cmd('highlight! TabLineFill guibg=NONE guifg=white')
