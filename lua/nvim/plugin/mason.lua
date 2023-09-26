local status,mason = pcall(require,"mason")
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
        'angularls',
        'volar',
        'jsonls',
        'tailwindcss',
        'emmet_ls',
        'bashls',
        'clangd',
        'rust_analyzer',
        'lemminx',
        'jdtls',
    },
    automatic_installation = {
        exclude = { "jdtls", 'intelephense'},
    },
    handlers = nil,
})
