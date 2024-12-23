return {
    "mfussenegger/nvim-dap",
    config = function()
        local _, dap = pcall(require, "dap")

        local configurations = dap.configurations

        configurations.cpp = {
            {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executeable: ", vim.fn.getcwd() .. "/", 'file')
                end,
                cwd = '${workspaceFolder}'
            }
        }



        vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })

        vim.keymap.set("n", "<leader>dab", dap.toggle_breakpoint, { desc = "Toggle breakpoint", silent = true })
        vim.keymap.set("n", "<leader>dac", dap.continue, { desc = "Continue", silent = true })
        vim.keymap.set("n", "<leader>dao", dap.step_over, { desc = "Step Over", silent = true })
        vim.keymap.set("n", "<leader>dai", dap.step_into, { desc = "Step Into", silent = true })
        vim.keymap.set("n", "<leader>dar", dap.repl.open, { desc = "Open", silent = true })
    end
}
