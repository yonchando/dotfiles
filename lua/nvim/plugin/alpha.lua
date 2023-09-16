local status_ok, neodev = pcall(require,"neodev")
if not status_ok then
    return
end

require'alpha'.setup(require'alpha.themes.dashboard'.config)
