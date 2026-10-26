-- mason
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require("mason-lspconfig").setup({
    automatic_enable = true,
    ensure_installed = {
        "vimls",
        "lua_ls",
    }
})

local registry = require("mason-registry")

local ensure_installed = {}

for _, v in ipairs({ "prettier", "prettierd" }) do
    if not registry.is_installed(v) then
        table.insert(ensure_installed, v)
    end
end

if next(ensure_installed) then
    vim.api.nvim_cmd({
        cmd = "MasonInstall",
        args = ensure_installed
    }, {})
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = 'lua',
    once = true,
    callback = function()
        vim.cmd("packadd lazydev.nvim")

        -- lazydev
        require("lazydev").setup({
            library = {
                {
                    path = "${3rd}/luv/library",
                    word = { "vim%.uv" }
                }
            }
        })
    end
})

-- angularls: add the completion flags the VS Code extension passes by default.
-- Set here because nvim-lspconfig's lsp/angularls.lua overrides cmd from our lsp/angularls.lua.
-- Its cmd builds the argv (probe locations, angularCoreVersion) and starts the server itself,
-- so the flags are appended when it calls vim.lsp.rpc.start
local angular_cmd = vim.lsp.config.angularls.cmd

if type(angular_cmd) == "function" then
    vim.lsp.config("angularls", {
        cmd = function(dispatchers, config)
            local rpc_start = vim.lsp.rpc.start
            vim.lsp.rpc.start = function(argv, ...)
                return rpc_start(vim.list_extend(argv, {
                    "--includeCompletionsWithSnippetText",
                    "--includeAutomaticOptionalChainCompletions",
                }), ...)
            end

            local ok, result = pcall(angular_cmd, dispatchers, config)
            vim.lsp.rpc.start = rpc_start

            if not ok then
                error(result, 0)
            end

            return result
        end,
    })
end

-- php folding from intelephense (overrides treesitter foldexpr)
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("IntelephenseFold", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client or client.name ~= "intelephense" or not client:supports_method("textDocument/foldingRange") then
            return
        end

        for _, win in ipairs(vim.fn.win_findbuf(args.buf)) do
            vim.wo[win][0].foldmethod = "expr"
            vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        end
    end
})

-- laravel ide-helper
local laravel_group = vim.api.nvim_create_augroup("LaravelIdeHelper", { clear = true })
local ide_helper_generated = {}

vim.api.nvim_create_autocmd("LspAttach", {
    group = laravel_group,
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client or client.name ~= "laravel_lsp" then
            return
        end

        local root = client.root_dir
        if not root or ide_helper_generated[root] then
            return
        end
        ide_helper_generated[root] = true

        local file = io.open(root .. "/composer.json", "r")
        if not file then
            return
        end
        local content = file:read("*a")
        file:close()

        local ok, composer = pcall(vim.json.decode, content)
        if not ok or type(composer) ~= "table" then
            return
        end

        local package = "barryvdh/laravel-ide-helper"
        local has_ide_helper = (composer["require"] and composer["require"][package])
            or (composer["require-dev"] and composer["require-dev"][package])
        if not has_ide_helper then
            return
        end

        local commands = {
            { "ide-helper:generate", "vendor/_ide_helper.php" },
            { "ide-helper:models", "--nowrite", "--filename=vendor/_ide_helper_models.php" },
        }

        local function run(index)
            local command = commands[index]
            if not command then
                -- restart intelephense so it indexes the generated helper files
                vim.schedule(function()
                    if next(vim.lsp.get_clients({ name = "intelephense" })) then
                        vim.cmd("lsp restart intelephense")
                    end
                end)
                return
            end

            vim.system({ "php", "artisan", unpack(command) }, { cwd = root, text = true }, function(result)
                vim.schedule(function()
                    if result.code == 0 then
                        vim.notify(command[1] .. " completed", vim.log.levels.INFO)
                    else
                        vim.notify(command[1] .. " failed: " .. (result.stderr or ""), vim.log.levels.ERROR)
                    end
                end)
                run(index + 1)
            end)
        end

        run(1)
    end
})
