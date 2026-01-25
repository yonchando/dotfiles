return {
    {
        'stevearc/conform.nvim',
        opts = {
            formatters_by_ft = {
                go = { "gofmt" },
                javascript = { "prettierd", "prettier", lsp_format = "fallback" },
                typescript = { "prettierd", "prettier", lsp_format = "fallback" },
                vue = { "prettierd", "prettier", lsp_format = "fallback" },
                json = { "prettierd", "prettier", lsp_format = "fallback" },
                yaml = { "prettierd", "prettier", lsp_format = "fallback" },
                yml = { "prettierd", "prettier", lsp_format = "fallback" },
                xml = { lsp_format = "fallback" },
            },
            format_on_save = {
                timeout_ms = 50000,
                lsp_format = "fallback",
            },
        },
        config = function(_, opts)
            local conform = require("conform")

            conform.setup(opts);

            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function(args)
                    conform.format({ bufnr = args.buf })
                end,
            })

            vim.keymap.set("n", "<leader>fc", function()
                conform.format({
                    timeout_ms = 50000,
                    dry_run = true,
                    lsp_format = "fallback"
                })
            end, { desc = "Conform format" })
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
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
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
        },
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
    {
        dir = "~/plugins/maven.nvim",
        cond = function()
            local stat = vim.uv.fs_stat(vim.env.HOME .. "/plugins/maven.nvim")

            return stat ~= nil
        end,
        opts = {},
    }
}
