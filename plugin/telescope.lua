local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        wrap_results = true,
        path_display = {
            "filename_first",
            "truncate",
        },
        preview = false
    },
    pickers = {
        find_files = {
            themes = 'ivy',
        },
        help_tags = {
            themes = 'ivy',
            mappings = {
                i = {
                    ["<CR>"] = function()
                        actions.select_vertical()
                    end
                },
            },
        }
    },
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
        },
        ['ui-select'] = {
            require("telescope.themes").get_dropdown()
        }
    }
})

require('telescope').load_extension('ui-select')
require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')

local findAll = function()
    builtin.find_files({
        hidden = true,
        no_ignore = true,
    })
end

local recentlyFiles = function()
    builtin.oldfiles({
        cwd_only = true,
    })
end

-- git vim-fugitive and telescope git
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = "Telescope git branches" })
vim.keymap.set('n', '<leader>gt', builtin.git_stash, { desc = "Telescope git stash" })
vim.keymap.set("n", "<leader>gs", function() vim.cmd('Git') end, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gc", function() vim.cmd('Git commit') end, { desc = "Git Commits" })
vim.keymap.set("n", "<leader>gd", function() vim.cmd('Git diff') end, { desc = "Git diff" })
vim.keymap.set("n", "<leader>gl", function() vim.cmd('Git log --oneline') end, { desc = "Git log" })
vim.keymap.set("n", "<leader>g.", function() vim.cmd('Gclog %') end, { desc = "Git log current file" })
vim.keymap.set("n", "<leader>gh", function() vim.cmd('diffget //2') end, { desc = "Git diffget ours (left)" })
vim.keymap.set("n", "<leader>gu", function() vim.cmd('diffget //3') end, { desc = "Git diffget theirs (right)" })
vim.keymap.set("n", "<leader>g1", function() vim.cmd('Gedit :1:%') end, { desc = "Git open base version (stage 1)" })

-- find file
vim.keymap.set('n', '<C-f>', builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set('n', '<C-e>', recentlyFiles, { desc = "Recently Files" })
vim.keymap.set('n', '<leader>ff', findAll, { desc = 'Telescope find all files include hidden and git ignore' })
vim.keymap.set('n', '<leader>fg', function()
    builtin.live_grep({
        preview = true,
    })
end, { desc = 'Telescope live grep' })
vim.keymap.set({ 'x' }, '<leader>ff', builtin.grep_string, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set("n", "<leader>dd", builtin.diagnostics, { desc = "Diagnostics" })

-- lsp
vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Lsp Definitions" })
vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "Lsp Implementations" })
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Lsp References" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Lsp References" })
vim.keymap.set("n", "gm", builtin.lsp_document_symbols, { desc = "Lsp Document Symbols" })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
vim.keymap.set("n", "<C-q>", vim.lsp.buf.hover, { desc = "LSP hover documentation" })
vim.keymap.set("i", "<A-p>", vim.lsp.buf.signature_help, { desc = "LSP signature help" })

vim.keymap.set({ 'n', 'v' }, "<leader>i", function()
    vim.lsp.buf.code_action()
end, { desc = "Lsp Auto-Fix / Auto-Import" })

vim.keymap.set({ 'n', 'v' }, "<leader><leader>i", function()
    vim.lsp.buf.code_action({
        context = {
            diagnostics = {},
            only = { "quickfix", "source.fixAll" }
        }
    })
end, { desc = "Lsp quickfix" })

vim.keymap.set({ 'n', 'v' }, "<leader>t", function()
    vim.lsp.buf.code_action({
        context = {
            diagnostics = {},
            only = { "refactor" }
        }
    })
end, { desc = "Lsp quickfix or refactor" })
