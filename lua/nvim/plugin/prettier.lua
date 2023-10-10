local status, prettier = pcall(require, "prettier")

if not status then
    return
end

prettier.setup({
    bin = "prettier",
    filetypes = {
        'css',
        'html',
        'json',
        'yaml',
        'yml',
        'javascript'
    },
    ["null-ls"] = {
        condition = function()
            return prettier.config_exists({
                check_package_json = true,
            })
        end,
        runtime_condition = function(params)
            return true
        end,
        timeout = 5000,
    },
    cli_options = {
        tab_width = 4
    }
})
