return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    version = "*",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        vim.opt.termguicolors = true

        local api = require("nvim-tree.api")

        api.git.timeout = 1000

        local function my_on_attach(bufnr)
            local function opts(desc)
                return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- default mapping
            api.config.mappings.default_on_attach(bufnr)
            --
            vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
            vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
            vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
            vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
            vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
            vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
            vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
            vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
            vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
            vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
            vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
            vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Filter: Dotfiles'))
            vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Filter: Git Ignore'))
            vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
            vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))

            vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
            vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
            vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
            vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
            vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
            vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
            vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
            vim.keymap.set('n', 'L', api.tree.expand_all, opts('Expand All'))
            vim.keymap.set('n', 'H', api.tree.collapse_all, opts('Collapse'))

            vim.keymap.set("n", "M", function()
                local node = api.tree.get_node_under_cursor()

                local ok, my_spaces = pcall(require, "my_spaces")

                if ok then
                    my_spaces.add_space({ path = node.absolute_path })
                end
            end, opts("Add to my space"))

            vim.keymap.set("n", "te", function()
                local node = api.tree.get_node_under_cursor()

                local ok, neotest = pcall(require, "neotest")

                if ok then
                    neotest.run.run(node.absolute_path)
                    api.tree.close()
                    neotest.output_panel.clear()
                    neotest.output_panel.open()
                end
            end)

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

        require("nvim-tree").setup {
            on_attach = my_on_attach,
            view = {
                relativenumber = true,
                width = 30,
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
                dotfiles = false,
            }
        }
        local opts = function(tbl)
            return vim.tbl_extend("keep", { noremap = true, silent = true }, tbl)
        end

        -- Nvim Tree
        local nvimtreeToggle = function()
            local tree = api.tree

            if tree.is_tree_buf() then
                tree.close()
            else
                tree.open()
            end
        end

        vim.keymap.set("n", "<M-1>", nvimtreeToggle, opts({ desc = "NvimTreeToggle" }))
        vim.keymap.set("n", "<leader><tab>", nvimtreeToggle, opts({ desc = "NvimTreeToggle" }))
    end
}
