local status, mason = pcall(require, "mason")
if not status then
    return
end

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "html",
        "cssls",
        "tsserver",
        "intelephense",
        'jsonls',
        'emmet_ls',
        'yamlls',
    },
    automatic_installation = false,
    handlers = nil,
})
