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
