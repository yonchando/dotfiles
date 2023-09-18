local status_ok, nvimtree = pcall(require, "nvim-tree")
if not status_ok then
    return
end

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local function my_on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return { desc = "nvim-tree" .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mapping
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set("n", "+", api.tree.expand_all, opts('Expand All'))
    vim.keymap.set("n", "_", api.tree.collapse_all, opts('Collapse All'))

    vim.keymap.set("n", '<leader>lff', api.live_filter.start, opts("Live filter"))
    vim.keymap.set("n", '<leader>lfc', api.live_filter.clear, opts("Live filter"))


    local Event = api.events.Event

    local resizePlus = function()
        vim.cmd("NvimTreeResize +20")
    end

    local resizeMinus = function()
        vim.cmd("NvimTreeResize -20")
    end

    vim.keymap.set("n", "<leader>>", resizePlus, opts("Nvimtree Resize by +20"))
    vim.keymap.set("n", "<leader><", resizeMinus, opts("NvimTree Resize by -20"))
end

nvimtree.setup {
    on_attach = my_on_attach,
    view = {
        relativenumber = true,
        width = 50
    }
}
