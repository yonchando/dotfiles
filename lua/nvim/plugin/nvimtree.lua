-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local function my_on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return {desc = "nvim-tree" .. desc, buffer = bufnr,noremap = true, silent = true, nowait = true }
    end

    -- default mapping
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set("n", "+", api.tree.expand_all, opts('Expand All'))
    vim.keymap.set("n", "_", api.tree.collapse_all, opts('Collapse All'))

end

-- empty setup using defaults
require("nvim-tree").setup {
    on_attach = my_on_attach,
    view = {
        relativenumber = true
    }
}
