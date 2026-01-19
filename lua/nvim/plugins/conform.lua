return {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                go = { "gofmt" },
                javascript = { "prettierd", lsp_format = "fallback" },
                typescript = { "prettierd", lsp_format = "fallback" },
                vue = { "prettier", "prettierd", lsp_format = "fallback" },
                json = { "prettier", "prettierd", lsp_format = "fallback" },
                yaml = { "prettier", "prettierd", lsp_format = "fallback" },
                yml = { "prettier", "prettierd", lsp_format = "fallback" },
                angular = { "prettierd", lsp_format = "fallback" }
            },
            default_format_opts = {
                lsp_format = "fallback",
            },
            format_on_save = {
                -- These options will be passed to conform.format()
                timeout_ms = 50000,
                lsp_format = "fallback",
            },
        });

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                conform.format({ bufnr = args.buf })
            end,
        })

        vim.keymap.set("n", "<leader>fc", conform.format, { desc = "Conform format" })
    end
}
