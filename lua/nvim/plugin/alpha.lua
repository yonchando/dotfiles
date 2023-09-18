local status_ok, aplha = pcall(require,"alpha")
if not status_ok then
    return
end

aplha.setup(require'alpha.themes.dashboard'.config)
