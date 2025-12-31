return {
    {
        'stevearc/conform.nvim',
        opts = {},
        config = function()
            local conform = require("conform")
            conform.setup({
                formatters_by_ft = {
                    go = { "gofmt" },
                    javascript = { "prettier", "prettierd", lsp_format = "fallback" },
                    typescript = { "prettier", "prettierd", lsp_format = "fallback" },
                    vue = { "prettier", "prettierd", lsp_format = "fallback" },
                    json = { "prettier", "prettierd", lsp_format = "fallback" },
                    yaml = { "prettier", "prettierd", lsp_format = "fallback" },
                    yml = { "prettier", "prettierd", lsp_format = "fallback" },
                },
                default_format_opts = {
                    lsp_format = "fallback",
                },
                format_on_save = {
                    -- These options will be passed to conform.format()
                    timeout_ms = 50000,
                    lsp_format = "fallback",
                },
            });

            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function(args)
                    conform.format({ bufnr = args.buf })
                end,
            })

            vim.keymap.set("n", "<leader>fc", conform.format, { desc = "Conform format" })
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
        config = function()
            require("ibl").setup({
                scope = {
                    show_start = false,
                    show_end = false,
                }
            })

            vim.opt.list = true
            vim.opt.listchars:append("space:⋅")
            vim.opt.fillchars:append("lastline:⋅")
        end
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            local bufferline = require("bufferline")

            vim.opt.termguicolors = true

            bufferline.setup({
                options = {
                    mode = 'buffers',
                    style_preset = bufferline.style_preset.minimal,
                    numbers = 'ordinal',
                    indicator = {
                        style = 'none'
                    },
                    modified_icon = '*',
                    diagnostics = 'nvim_lsp',
                    diagnostics_update_on_event = true,
                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        if level == 'error' then
                            return "e"
                        end
                        return ""
                    end,
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            text_alisgn = "center",
                            separator = true
                        }
                    }
                }
            })

            local opts = function(tbl)
                return vim.tbl_extend("keep", { noremap = true, silent = true }, tbl)
            end
            local tab = function(tabIndex)
                return function()
                    bufferline.go_to(tabIndex, true)
                end
            end
            vim.keymap.set("n", "<A-w>", vim.cmd.Bdelete, opts({ desc = "Bdelete" }))
            vim.keymap.set("n", "<A-b>", vim.cmd.close, opts({ desc = "Vim Close" }))
            vim.keymap.set("n", "<leader>cl", vim.cmd.BufferLineCloseLeft, opts({ desc = "Close all left buffer" }))
            vim.keymap.set("n", "<leader>cr", vim.cmd.BufferLineCloseRight, opts({ desc = "Close all right buffer" }))
            vim.keymap.set("n", "<leader>co", vim.cmd.BufferLineCloseOthers, opts({ desc = "Close others" }))

            vim.keymap.set("n", "[t", vim.cmd.BufferLineMovePrev, opts({ desc = "Close others" }))
            vim.keymap.set("n", "]t", vim.cmd.BufferLineMoveNext, opts({ desc = "Close others" }))

            vim.keymap.set("n", "<Tab>", vim.cmd.BufferLineCycleNext, opts({ desc = "Close others" }))
            vim.keymap.set("n", "<S-Tab>", vim.cmd.BufferLineCyclePrev, opts({ desc = "Close others" }))

            vim.keymap.set("n", '<leader>1', tab(1), opts({ desc = "Go to tab 1" }))
            vim.keymap.set("n", '<leader>2', tab(2), opts({ desc = "Go to tab 2" }))
            vim.keymap.set("n", '<leader>3', tab(3), opts({ desc = "Go to tab 3" }))
            vim.keymap.set("n", '<leader>4', tab(4), opts({ desc = "Go to tab 4" }))
            vim.keymap.set("n", '<leader>5', tab(5), opts({ desc = "Go to tab 5" }))
            vim.keymap.set("n", '<leader>6', tab(6), opts({ desc = "Go to tab 6" }))
            vim.keymap.set("n", '<leader>7', tab(7), opts({ desc = "Go to tab 7" }))
            vim.keymap.set("n", '<leader>8', tab(8), opts({ desc = "Go to tab 8" }))
            vim.keymap.set("n", '<leader>9', tab(9), opts({ desc = "Go to tab 9" }))
            vim.keymap.set("n", '<leader>$', tab(-1), opts({ desc = "Go to tab last" }))
            vim.keymap.set("n", "<leader>`", vim.cmd.BufferLinePick, opts({ desc = "Buffer pick tab" }))
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            {
                'nvim-tree/nvim-web-devicons',
                lazy = true,
            },
            {
                "folke/tokyonight.nvim",
                lazy = false,
                priority = 1000,
                opts = {},
                config = function()
                    local tokyonight = require('tokyonight')

                    tokyonight.setup({
                        style = "moon",
                        transparent = true,
                        terminal_colors = true,
                        styles = {
                            comments = { italic = true },
                            keywords = { italic = true },
                            floats = "dark",
                        }
                    })

                    vim.cmd [[colorscheme tokyonight]]
                end
            }

        },
        config = function()
            local status_ok, lualine = pcall(require, "lualine")
            if not status_ok then
                return
            end

            lualine.setup {
                options = {
                    icons_enabled = true,
                    theme = 'tokyonight',
                    component_separators = { left = '<', right = '<' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    }
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch' },
                    lualine_c = {
                        {
                            'filename',
                            path = 1,
                            file_status = false,
                        }
                    },
                    lualine_x = {
                        -- {
                        --     require("noice").api.status.command.get,
                        --     cond = require("noice").api.status.command.has,
                        --     color = { fg = "#ff9e64" },
                        -- },
                        'encoding',
                        'fileformat',
                        { 'filetype', colored = false, icon_only = false }
                    },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {}
            }
        end
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        enabled = true,
        opts = {},
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            local noice = require("noice")
            noice.setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = false, -- requires hrsh7th/nvim-cmp
                    },
                },
                presets = {
                    bottom_search = true,         -- use a classic bottom cmdline for search
                    command_palette = true,       -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false,       -- add a border to hover docs and signature help
                },
            })

            local opts = function(tbl)
                return vim.tbl_extend("keep", { silent = true, noremap = true }, tbl)
            end

            vim.keymap.set("n", "<leader>nc", function()
                noice.cmd("dismiss")
            end, opts({ desc = "Noice dismiss" }))

            vim.keymap.set("n", "<leader>nl", function()
                noice.cmd("last")
            end, opts({ desc = "Noice last" }))

            vim.keymap.set("n", "<leader>nh", function()
                noice.cmd("viewstats")
            end, opts({ desc = "Noice history" }))

            vim.keymap.set("n", "<leader>na", function()
                noice.cmd("all")
            end, opts({ desc = "Noice all" }))
        end
    },
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set("n", "<leader>gs", function() vim.cmd('Git') end, { desc = "Git Status" })
            vim.keymap.set("n", "<leader>gc", function() vim.cmd('Git commit') end, { desc = "Git Commits" })
            vim.keymap.set("n", "<leader>gd", function() vim.cmd('Git diff') end, { desc = "Git diff" })
            vim.keymap.set("n", "<leader>gl", function() vim.cmd('Git log') end, { desc = "Git log" })
            vim.keymap.set("n", "<leader>gmtl", function() vim.cmd('Git mergetool') end, { desc = "Git mergetool" })
            vim.keymap.set("n", "<leader>g.", function() vim.cmd('Gclog %') end, { desc = "Git mergetool" })
        end
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        config = function()
            require("nvim-surround").setup()
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require("gitsigns").setup {
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end
                    map('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, { expr = true, desc = "Gitsigns next_hunk" })
                    map('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, { expr = true, desc = "Gitsigns prev_hunk" })

                    map('n', '<leader>hs', gs.stage_hunk)
                    map('n', '<leader>hr', gs.reset_hunk)
                    map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
                    map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
                    map('n', '<leader>hS', gs.stage_buffer)
                    map('n', '<leader>hu', gs.undo_stage_hunk)
                    map('n', '<leader>hR', gs.reset_buffer)
                    map('n', '<leader>hp', gs.preview_hunk)
                    map('n', '<leader>hb', function() gs.blame_line { full = true } end)
                    map('n', '<leader>tb', gs.toggle_current_line_blame)
                    map('n', '<leader>hd', gs.diffthis)
                    map('n', '<leader>hD', function() gs.diffthis('~') end)
                    map('n', '<leader>td', gs.toggle_deleted)

                    -- Text object
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Gitsigns select_hunk" })
                end
            }
        end
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    { "christoomey/vim-tmux-navigator", },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    { "famiu/bufdelete.nvim" },
    {
        "RRethy/vim-illuminate",
        config = function()
            require("illuminate").configure()

            vim.api.nvim_set_hl(0, "Visual", { bg = "#2d3f76" })
            vim.api.nvim_set_hl(0, "IlluminatedWordColor", { bg = "#23315c" })

            -- change the highlight style
            vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "IlluminatedWordColor" })
            vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "IlluminatedWordColor" })
            vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "IlluminatedWordColor" })

            --- auto update the highlight style on colorscheme change
            vim.api.nvim_create_autocmd({ "ColorScheme" }, {
                pattern = { "*" },
                callback = function()
                    vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "IlluminatedWordColor" })
                    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "IlluminatedWordColor" })
                    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "IlluminatedWordColor" })
                end
            })
        end
    },
    {
        'andymass/vim-matchup',
        init = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end
    },
    {
        'mg979/vim-visual-multi',
        branch = 'master'
    },
}
