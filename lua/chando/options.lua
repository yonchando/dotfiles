vim.loader.enable()

vim.g.mapleader = " "
vim.o.relativenumber = true
vim.wo.number = true
vim.o.mouse = "a"

vim.opt.wrap = false

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.spell = true
vim.opt.spelllang = 'en_us'

vim.o.termguicolors = true

vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Folding (treesitter-based, see plugin/nvim-treesitter.lua)
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldtext = ""
vim.opt.fillchars:append({ fold = " " })

vim.o.signcolumn = "yes"
vim.o.colorcolumn = "80"
vim.opt.isfname:append("@-@")

-- yank highlight
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})
