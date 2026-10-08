--- @type vim.lsp.Config
return {
    ---@type lspconfig.settings.tailwindcss
    settings = {
        tailwindCSS = {
            classFunctions = {
                "cn",
                "cva",
                "twMerge",
                "clsx"
            },
            experimental = {
                classRegex = {
                    "className[A-Za-z]*\\s*=\\s*[\"'`]([^\"'`]*)[\"'`]"
                }
            }
        }
    }
}
