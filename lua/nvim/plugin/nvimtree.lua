local status_ok, nvimtree = pcall(require, "nvim-tree")
if not status_ok then
    return
end

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local api = require("nvim-tree.api")

local function my_on_attach(bufnr)
    local function opts(desc)
        return { desc = "nvim-tree" .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mapping
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set("n", "+", api.tree.expand_all, opts('Expand All'))
    vim.keymap.set("n", "_", api.tree.collapse_all, opts('Collapse All'))

    vim.keymap.set("n", '<leader>lf', api.live_filter.start, opts("Live filter"))
    vim.keymap.set("n", '<leader>lc', api.live_filter.clear, opts("Live filter clean"))

    local resize = function(size)
        return function()
            vim.cmd("NvimTreeResize " .. size)
        end
    end

    vim.keymap.set("n", "<leader>>", resize("+20"), opts("Nvimtree Resize by +20"))
    vim.keymap.set("n", "<leader><", resize("-20"), opts("NvimTree Resize by -20"))
end

local goToFile = function()
    local file = vim.api.nvim_buf_get_name(0)

    api.tree.find_file({
        buf = file,
        open = true,
        focus = true
    })
end
vim.keymap.set("n", "<leader>gf", goToFile, { desc = "Go to current file in nvimtree" })

nvimtree.setup {
    on_attach = my_on_attach,
    view = {
        relativenumber = true,
        width = 50
    },
    renderer = {
        icons = {
            show = {
                git = false
            }
        },
        highlight_git = true,
        indent_markers = {
            enable = true,
            icons = {
                corner = "│",
                edge = "│",
                item = "│",
                bottom = "─",
                none = " ",
            }
        }
    },
    filters = {
        git_ignored = false
    }
}
