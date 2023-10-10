local status_ok, ibl = pcall(require, "ibl")
if not status_ok then
    return
end

vim.opt.list = true
vim.opt.listchars:append "space:⋅"

ibl.setup({})
