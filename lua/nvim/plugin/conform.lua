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
        blade = { "blade-formatter" },
        yaml = { "prettier" }
    },
    format_on_save = {
        lsp_fallback = true,
    },
})

vim.keymap.set({ "n", "v" }, "<leader>fc", function()
    conform.format({
        lsp_fallback = true,
        timeout_ms = 50000,
    })
end, { desc = "Reformat file or range ( in Select mode)", noremap = true, silent = true })
