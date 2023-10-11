local status_ok, nvimtree = pcall(require, "nvim-tree")
if not status_ok then
    return
end

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- code completion highlight color
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
    vim.keymap.set("n", "n+", api.tree.expand_all, opts('Expand All'))
    vim.keymap.set("n", "n_", api.tree.collapse_all, opts('Collapse All'))

    vim.keymap.set("n", 'nlf', api.live_filter.start, opts("Live filter"))
    vim.keymap.set("n", 'nlc', api.live_filter.clear, opts("Live filter clean"))

    local resize = function(size)
        return function()
            vim.cmd("NvimTreeResize " .. size)
        end
    end

    local git_add = function(command)
        local node = api.tree.get_node_under_cursor()
        local gs = node.git_status.file

        -- If the current node is a directory get children status
        if gs == nil then
            gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1])
                or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
        end


        if command == "add" then
            -- If the file is untracked, unstaged or partially staged, we stage it
            if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
                vim.cmd("silent !git add " .. node.absolute_path)

                -- If the file is staged, we unstage
            elseif gs == "M " or gs == "A " then
                vim.cmd("silent !git restore --staged " .. node.absolute_path)
            end
        end

        if command == "reset" then
            if gs == "M " or gs == "A " then
                vim.cmd("silent !git restore --staged " .. node.absolute_path)
            end
            vim.cmd("silent !git checkout " .. node.absolute_path)
        end

        api.tree.reload()
    end

    vim.keymap.set('n', "nga", function() git_add('add') end, { desc = "Git add" })
    vim.keymap.set('n', "ngr", function() git_add('reset') end, { desc = "Git reset" })

    vim.api.nvim_set_hl(0, "NvimTreeGitStaged", { fg = "#B03AFC" })
    vim.api.nvim_set_hl(0, "NvimTreeGitNew", { fg = "#84E873" })
    vim.api.nvim_set_hl(0, "NvimTreeFileRenamed", { link = "NvimTreeGitNew" })
    vim.api.nvim_set_hl(0, "NvimTreeGitDirty", { fg = "#6897BB" })
    vim.api.nvim_set_hl(0, "NvimTreeGitIgnored", { fg = "#848504" })
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
        width = 50,
        float = {
            enable = true,
            open_win_config = {
                title = "Project",
                title_pos = "center",
                relative = "editor",
                border = "rounded",
                width = 120,
                height = 30,
                row = 4,
                col = 30
            }
        }
    },
    renderer = {
        indent_width = 2,
        icons = {
            show = {
                git = false
            },
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
        git_ignored = true
    }
}
