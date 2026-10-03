require("nvim-autopairs").setup {}

local theme = require("tokyonight")
theme.setup({
    style = "moon",
    transparent = true,
    terminal_colors = true,
    styles = {
        comments = { italic = true },
        keywords = { italic = true },
        floats = "dark",
    },
    on_colors = function() end,
    on_highlights = function() end,
})
vim.cmd [[colorscheme tokyonight]]

-- indent blankline
require("ibl").setup({
    scope = {
        show_start = false,
        show_end = false,
    }
})
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.fillchars:append("lastline:⋅")

-- mason
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require("mason-lspconfig").setup({
    automatic_enable = true,
    ensure_installed = {
        "vimls",
        "lua_ls",
    }
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = 'lua',
    once = true,
    callback = function()
        vim.cmd("packadd lazydev.nvim")

        -- lazydev
        require("lazydev").setup({
            library = {
                {
                    path = "${3rd}/luv/library",
                    word = { "vim%.uv" }
                }
            }
        })
    end
})

-- noice
local noice = require("noice")
noice.setup({
    lsp = {
        signature = {
            auto_open = {
                enabled = false
            }
        },
        override = {
            -- override the default lsp markdown formatter with Noice
            ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
            -- override the lsp markdown formatter with Noice
            ["vim.lsp.util.stylize_markdown"] = false,
            -- override cmp documentation with Noice (needs the other options to work)
            ["cmp.entry.get_documentation"] = false,
        }
    }
})
vim.keymap.set("n", "<leader>nc", ":Noice dismiss<CR>", { silent = true })
vim.keymap.set("n", "<leader>na", ":Noice all<CR>", { silent = true })

-- git vim-fugitive
vim.keymap.set("n", "<leader>gs", function() vim.cmd('Git') end, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gc", function() vim.cmd('Git commit') end, { desc = "Git Commits" })
vim.keymap.set("n", "<leader>gd", function() vim.cmd('Git diff') end, { desc = "Git diff" })
vim.keymap.set("n", "<leader>gl", function() vim.cmd('Git log --oneline') end, { desc = "Git log" })
vim.keymap.set("n", "<leader>gmtl", function() vim.cmd('Git mergetool') end, { desc = "Git mergetool" })
vim.keymap.set("n", "<leader>g.", function() vim.cmd('Gclog %') end, { desc = "Git log current file" })
vim.keymap.set("n", "<leader>gh", function() vim.cmd('diffget //2') end, { desc = "Git diffget ours (left)" })
vim.keymap.set("n", "<leader>gu", function() vim.cmd('diffget //3') end, { desc = "Git diffget theirs (right)" })
vim.keymap.set("n", "<leader>g1", function() vim.cmd('Gedit :1:%') end, { desc = "Git open base version (stage 1)" })

-- multiple cursor
require("multiple-cursors").setup()
vim.keymap.set({ "n", "x" }, "<C-n>", function() vim.cmd('MultipleCursorsAddDown') end,
    { desc = "Add multiple cursor down" })
vim.keymap.set({ "n", "x" }, "<C-p>", function() vim.cmd('MultipleCursorsAddUp') end, { desc = "Add multiple cursor up" })
vim.keymap.set({ "n", "x" }, "<A-j>", function() vim.cmd('MultipleCursorsAddJumpNextMatch') end,
    { desc = "Select next match" })
vim.keymap.set({ "n", "x" }, "<A-k>", function() vim.cmd('MultipleCursorsAddJumpPrevMatch') end,
    { desc = "Select previous match" })
vim.keymap.set({ "n", "x" }, "<A-x>", function() vim.cmd('MultipleCursorsJumpNextMatch') end,
    { desc = "Add multiple cursor up" })
