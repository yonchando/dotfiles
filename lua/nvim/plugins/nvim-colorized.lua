return {
    "NvChad/nvim-colorizer.lua",
    config = function()
        local status, colorizer = pcall(require, 'colorizer')

        if not status then
            return
        end

        local config = {
            mode = "background",
            css = true,
            tailwind = true,
            sass = {
                enable = true,
                parser = { "css", "scss" }
            }
        }

        colorizer.setup(config)
    end
}
