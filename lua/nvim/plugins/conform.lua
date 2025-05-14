return {
    'stevearc/conform.nvim',
    event = { "BufWritePre" },
    keys = {
        {
            "<leader>fc",
            function()
                require("conform").format({
                    async = true,
                    lsp_fallback = true,
                    timeout_ms = 50000,
                })
            end,
            mode = "",
            desc = "Reformat file or range ( in Select mode)"
        }
    },
    opts = {
        formatters_by_ft = {
            javascript = { "prettier", lsp_format = "fallback" },
            typescript = { "eslint", "prettier", lsp_format = "fallback" },
            html = { "prettier", lsp_format = "fallback" },
            css = { "prettier", lsp_format = "fallback" },
            scss = { "prettier", lsp_format = "fallback" },
            json = { "prettier", lsp_format = "fallback" },
            blade = { "blade-formatter", lsp_format = "fallback" },
            yaml = { "prettier", lsp_format = "fallback" },
            php = { 'pint', 'php_cs_fixer', lsp_format = "fallback" },
            cpp = { "clang-format", lsp_format = "fallback" },
            bash = { "clang-format", lsp_format = "fallback" },
        },

        format_on_save = {
            lsp_fallback = true,
            timeout_ms = 50000,
        },
        formatters = {
            shfmt = {
                prepend_args = { "-i", "4" }
            }
        },
        -- Set the log level. Use `:ConformInfo` to see the location of the log file.
        log_level = vim.log.levels.ERROR,

        notify_on_error = true,
        -- Conform will notify you when no formatters are available for the buffer
        notify_no_formatters = true,
        -- Custom formatters and overrides for built-in formatters
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end
}
