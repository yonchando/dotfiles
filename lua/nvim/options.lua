vim.g.mapleader = " "
vim.g.EasyMotion_do_mapping = 0
vim.o.shiftwidth = 4
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.expandtab = true
vim.opt.clipboard = 'unnamedplus'
vim.loader.enable()
vim.g.nohlsearch = true

-- [[ Highlight on yank ]]
-- -- See `:help vim.highlight.on_yank()`
-- local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    pattern = '*',
})
