local status_ok, neodev = pcall(require,"which-key")
if not status_ok then
    return
end

vim.o.timeout = true
vim.o.timeoutlen = 300
require("which-key").setup {}
