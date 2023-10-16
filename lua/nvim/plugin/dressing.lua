local status, dressing = pcall(require, 'dressing')

if not status then
    return
end

dressing.setup({
    input = {
        enabled = true,
        title_pos = "center",
        relative = "cursor"
    },
    select = {
        enabled = true,
        backend = { "nvim-tree" }
    }
})
