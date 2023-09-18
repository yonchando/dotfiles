local status_ok, laravel = pcall(require, "laravel")
if not status_ok then
    return
end

laravel.setup({
    cmd = {
        "Sail",
        "Artisan",
        "Composer",
        "Npm",
        "Yarn",
        "Laravel"
    },
})
