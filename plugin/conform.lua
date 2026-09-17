local conform = require("conform")


conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run the first available formatter
        javascript = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        htmlangular = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
    },
    format_on_save = {
        timeout_ms = 50000,
        lsp_format = "fallback"
    }
})

vim.keymap.set("n", "<leader>fsc", function()
    local bufnr = vim.api.nvim_get_current_buf()
    conform.format({
        bufnr = bufnr
    })
end)
