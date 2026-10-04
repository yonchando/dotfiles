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
        typescript = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        htmlangular = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
    },
    format_on_save = {
        timeout_ms = 50000,
        lsp_format = "fallback"
    }
})

local opts = function(tbl)
    return vim.tbl_extend("keep", { noremap = true, silent = true }, tbl)
end

vim.keymap.set("n", "<leader>fc", function()
    local bufnr = vim.api.nvim_get_current_buf()
    for _, name in ipairs({ "prettierd", "prettier" }) do
        if conform.get_formatter_info(name, bufnr).available then
            conform.format({ bufnr = bufnr, formatters = { name } })
            return
        end
    end
    vim.lsp.buf.format({ bufnr = bufnr })
end, opts({ desc = "Format with prettier, fallback to LSP" }))
