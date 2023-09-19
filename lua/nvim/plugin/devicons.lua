local status_ok, devicons = pcall(require, "nvim-web-devicons")
if not status_ok then
    return
end

devicons.setup {
    override = {
        zsh = {
            icon = "",
            color = "#428850",
            cterm_color = "65",
            name = "Zsh"
        }
    },
    color_icons = true,
    default = true,
    strict = true,
}
