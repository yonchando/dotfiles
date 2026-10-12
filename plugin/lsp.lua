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
