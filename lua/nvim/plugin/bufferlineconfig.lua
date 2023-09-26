local status_ok,bufferline = pcall(require,"bufferline")
if not status_ok then
    return
end

vim.opt.termguicolors = true

bufferline.setup{
    options = {
        mode = "buffers",
        style_preset = bufferline.style_preset.default,
        themable = false,
        numbers = "ordinal",
        indicator = {
            style = "none"
        },
        modified_icon = '*',
        max_name_length = 18,
        tab_size = 18
    }
}
