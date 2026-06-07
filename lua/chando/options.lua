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

-- yank highlight
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- vim.opt.autocomplete = true
vim.opt.completeopt = "menu,menuone,noselect,popup"

-- Automatically enable LSP completion when a server attaches
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, args.data.client_id, args.buf, { autotrigger = true })
    end
  end,
})
