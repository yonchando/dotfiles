vim.g.mapleader = " "
vim.o.relativenumber = true
vim.wo.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.loader.enable()
vim.o.smartindent = true
vim.o.mouse = "a"
vim.o.undofile = true
vim.opt.wrap = false

vim.opt.spell = true
vim.opt.spelllang = 'en_us'

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.termguicolors = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- yank highlight
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

vim.filetype.add({
    extension = {
        dbml = 'dbml'
    }
})

vim.api.nvim_create_autocmd("User", {
    pattern = "TSUpdate",
    callback = function()
        require("nvim-treesitter.parsers").dbml = {
            install_info = {
                url = "https://github.com/yonchando/tree-sitter-dbdiagram",
                revision = "fc8fc30a2ff83568694a85a4354d111cadaf70a6",
                branch = "main",
                generate_requires_npm = false,
                requires_generate_from_grammar = false,
            },
            tier = 2,
        }
    end
})
