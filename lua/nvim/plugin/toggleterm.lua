local status_ok, neodev = pcall(require,"toggleterm")
if not status_ok then
    return
end

require("toggleterm").setup()
