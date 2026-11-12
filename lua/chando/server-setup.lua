local language_setup = {
    "php",
    "angular",
    "java",
    "docker"
}

local lsp_names = {
    php = {
        "laravel_lsp",
        "intelephense",
    },
    angular = {
        "angularls",
        "vtsls",
    },
    docker = {
        "docker_language_server"
    },
    java = {
        "jdtls",
    },
}

-- mason packages that are not lspconfig servers (installed via :MasonInstall)
local mason_packages = {
    java = {
        "vscode-spring-boot-tools",
    },
}

vim.api.nvim_create_user_command("SetupServer", function(opts)
    local status, mlspconfig = pcall(require, "mason-lspconfig")

    if status then
        local installed = {}
        local lsp = {
            "tailwindcss",
        }
        local packages = {}

        local languages = opts.args == "" and language_setup or vim.split(opts.args, " ")

        for _, value in ipairs(languages) do
            if lsp_names[value] or mason_packages[value] then
                vim.list_extend(lsp, lsp_names[value] or {})
                vim.list_extend(packages, mason_packages[value] or {})
            elseif opts.args ~= "" then
                vim.notify("Language invalid: " .. value, vim.log.levels.WARN)
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

        local registry = require("mason-registry")
        local missing = vim.tbl_filter(function(name)
            return not registry.is_installed(name)
        end, packages)

        if next(missing) then
            vim.api.nvim_cmd({
                cmd = "MasonInstall",
                args = missing
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
