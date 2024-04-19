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

        dap.adapters.java = function(callback, config)
            M.execute_command({ command = 'vscode.java.startDebugSession' }, function(err0, port)
                assert(not err0, vim.inspect(err0))
                callback({ type = "server", host = "127.0.0.1", port = port })
            end)
        end

        vim.keymap.set("n", "<leader>dab", dap.toggle_breakpoint, { desc = "Toggle breakpoint", silent = true })
        vim.keymap.set("n", "<leader>dac", dap.continue, { desc = "Continue", silent = true })
        vim.keymap.set("n", "<leader>dao", dap.step_over, { desc = "Step Over", silent = true })
        vim.keymap.set("n", "<leader>dai", dap.step_into, { desc = "Step Into", silent = true })
        vim.keymap.set("n", "<leader>dar", dap.repl.open, { desc = "Open", silent = true })
    end
}