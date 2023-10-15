local status, conform = pcall(require, "conform")

if not status then
    return
end

conform.setup({
    formatters_by_ft = {
        javascript = { "prettier" },
        vue = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        json = { "prettier" },
        php = { "php_cs_fixer" },
        blade = { "blade-formatter" },
    },
    format_on_save = {
        timeout_ms = 500,
        async = false,
        lsp_fallback = true,
    },
})

vim.keymap.set({ "n", "v" }, "<leader>fc", function()
    conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
    }, { desc = "Reformat file or range ( in Select mode)"})
end)
