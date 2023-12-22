return {
    "mfussenegger/nvim-dap",
    config = function()
        local _, dap = pcall(require, "dap")



        dap.adapters.cppdbg = {
            id = "cppdbg",
            type = "executable",
            command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
        }

        dap.configurations.cpp = {
            {
                name = "Launch file",
                type = "cppdbg",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopAtEntry = true,
            },
            {
                name = 'Attach to gdbserver :1234',
                type = 'cppdbg',
                request = 'launch',
                MIMode = 'gdb',
                miDebuggerServerAddress = 'localhost:1234',
                miDebuggerPath = '/usr/bin/gdb',
                cwd = '${workspaceFolder}',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
            },
        }

        vim.keymap.set("n", "<leader>dab", dap.toggle_breakpoint, { desc = "Toggle breakpoint", silent = true })
        vim.keymap.set("n", "<leader>dac", dap.toggle_breakpoint, { desc = "Toggle breakpoint", silent = true })
        vim.keymap.set("n", "<leader>dao", dap.toggle_breakpoint, { desc = "Toggle breakpoint", silent = true })
        vim.keymap.set("n", "<leader>dai", dap.toggle_breakpoint, { desc = "Toggle breakpoint", silent = true })
        vim.keymap.set("n", "<leader>dar", dap.toggle_breakpoint, { desc = "Toggle breakpoint", silent = true })
    end
}
