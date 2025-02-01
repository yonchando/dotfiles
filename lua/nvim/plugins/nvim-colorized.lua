return {
    "NvChad/nvim-colorizer.lua",
    enabled = false,
    config = function()
        local status, colorizer = pcall(require, 'colorizer')

        if not status then
            return
        end

        local config = {
            mode = "background",
            css = true,
            tailwind = false,
            sass = {
                enable = true,
                parser = { "css", "scss" }
            }
        }

        colorizer.setup(config)
    end
}
