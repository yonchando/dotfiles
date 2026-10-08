local language_setup = {
    "php",
    "angular",
    "java",
    "docker"
}

local lsp_names = {
    php = {
        "laravel_ls",
        "intelephense",
    },
    angular = {
        "angularls",
        "ts_ls",
    },
    docker = {
        "docker_language_server"
    }
}

vim.api.nvim_create_user_command("SetupServer", function(opts)
    local status, mlspconfig = pcall(require, "mason-lspconfig")

    if status then
        local installed = {}
        local lsp = {
            "tailwindcss",
        }

        if opts.args == "" then
            for _, value in ipairs(language_setup) do
                if lsp_names[value] then
                    lsp = vim.list_extend(lsp, lsp_names[value])
                end
            end
        else
            for _, value in ipairs(vim.split(opts.args, " ")) do
                if lsp_names[value] then
                    lsp = vim.list_extend(lsp, lsp_names[value])
                else
                    vim.notify("Language invalid", vim.log.levels.WARN)
                end
            end
        end

        local installed_services = mlspconfig.get_installed_servers()

        for _, value in ipairs(lsp) do
            if not vim.list_contains(installed_services, value) then
                table.insert(installed, value)
            end
        end

        if next(installed) then
            vim.api.nvim_cmd({
                cmd = "LspInstall",
                args = installed
            }, {})
        end
    end
end, {
    desc = "Install language server laravel_ls angularls tailwindcss ts_ls",
    nargs = '?',
    complete = function()
        return language_setup
    end
})
