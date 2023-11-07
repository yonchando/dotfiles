return {
    'echasnovski/mini.nvim',
    branch = 'stable',
    config = function()
        local status, starter = pcall(require, "mini.starter")

        if not status then
            return
        end

        starter.setup({
            items = {
                starter.sections.recent_files(5, true),
                starter.sections.builtin_actions(),
            }
        })
    end
}
