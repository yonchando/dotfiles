local status, starter = pcall(require, "mini.starter")

if not status then
    return
end

starter.setup({
    items = {
        starter.sections.builtin_actions(),
        starter.sections.recent_files(5, true),
    }
})
