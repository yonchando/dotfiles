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

api.events.subscribe(api.events.Event.FileCreated, function(file)
    vim.cmd("edit " .. file.fname)
end)

local function my_on_attach(bufnr)
    local function opts(desc)
        return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mapping
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set("n", "n+", api.tree.expand_all, opts('Expand All'))
    vim.keymap.set("n", "n_", api.tree.collapse_all, opts('Collapse All'))

    vim.keymap.set("n", 'lf', api.live_filter.start, opts("Live filter"))
    vim.keymap.set("n", 'lc', api.live_filter.clear, opts("Live filter clean"))

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

    vim.keymap.set('n', "ga", function() git_add('add') end, opts("Git Add"))
    vim.keymap.set('n', "gr", function() git_add('reset') end, opts("Git reset"))

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
            open_win_config = function()
                local screen_w = vim.opt.columns:get()
                local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                local window_w = screen_w * 0.8
                local window_h = screen_h * 0.8
                local window_w_int = math.floor(window_w)
                local window_h_int = math.floor(window_h)
                local center_x = (screen_w - window_w) / 2
                local center_y = ((vim.opt.lines:get() - window_h) / 2)
                    - vim.opt.cmdheight:get()
                return {
                    title = "Project",
                    title_pos = "left",
                    border = 'rounded',
                    relative = 'editor',
                    row = center_y,
                    col = center_x,
                    width = window_w_int,
                    height = window_h_int,
                }
            end,
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
