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
            javascript = { "prettier" },
            html = { "prettier" },
            css = { "prettier" },
            scss = { "prettier" },
            json = { "prettier" },
            blade = { "blade-formatter" },
            yaml = { "prettier" },
            php = { 'pint', 'php_cs_fixer' }
        },

        format_on_save = {
            lsp_fallback = true,
            timeout_ms = 50000,
        },
        formatters = {
            shfmt = {
                prepend_args = { "-i", "4" }
            }
        }
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end
}
