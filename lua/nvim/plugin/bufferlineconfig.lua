local status_ok,buffer = pcall(require,"bufferline")
if not status_ok then
    return
end

vim.opt.termguicolors = true
buffer.setup{}
