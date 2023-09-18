vim.g.mapleader = " "
vim.g.EasyMotion_do_mapping = 0
vim.o.shiftwidth = 4
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.expandtab = true
vim.opt.clipboard = 'unnamedplus'
vim.loader.enable()
vim.o.smartindent = false

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    pattern = '*',
})
