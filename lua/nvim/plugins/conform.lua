return {
  'stevearc/conform.nvim',
  opts = {},
  config = function()
    local conform = require("conform")
    conform.setup({
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
