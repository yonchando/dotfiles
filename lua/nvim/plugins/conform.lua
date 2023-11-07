return {
    'stevearc/conform.nvim',
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                javascript = { "prettier" },
                vue = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
                scss = { "prettier" },
                json = { "prettier" },
                blade = { "prettier" },
                -- java = { "clang_format" }
                blade = { "blade-formatter" },
                yaml = { "prettier" }
            },
            format_on_save = {
                lsp_fallback = true,
                timeout_ms = 50000,
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>fc", function()
            conform.format({
                lsp_fallback = true,
                timeout_ms = 50000,
            })
        end, { desc = "Reformat file or range ( in Select mode)", noremap = true, silent = true })
    end
}
