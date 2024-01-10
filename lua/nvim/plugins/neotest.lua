return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "olimorris/neotest-phpunit",
        "rcasia/neotest-java",
        "theutz/neotest-pest",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-pest"),
                require("neotest-phpunit"),
                require("neotest-java")({
                    ignore_wrapper = false,
                }),
            },
            icons = {
                child_indent = "│",
                child_prefix = "├",
                collapsed = "─",
                expanded = "╮",
                failed = "",
                final_child_indent = " ",
                final_child_prefix = "╰",
                non_collapsible = "─",
                passed = "",
                running = "",
                running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
                skipped = "",
                unknown = "",
                watching = ""
            },
            output = {
                enabled = false,
            },
            output_panel = {
                enabled = true,
                open = "botright split | resize 15"
            },
        })

        local neotest = require("neotest")

        vim.keymap.set("n", "<leader>ro", neotest.output_panel.toggle, { desc = "Run test results" })
        vim.keymap.set("n", "<leader>rs", neotest.summary.toggle, { desc = "Run test results" })

        local run = require("neotest").run

        local togglePanel = function()
            neotest.output_panel.close()
            neotest.output_panel.clear()
            neotest.output_panel.open({
                enter = true,
                auto_close = true
            })
        end

        vim.keymap.set("n", "<leader>re", function()
            run.run()
            togglePanel()
        end, { desc = "Run single test" })

        vim.keymap.set("n", "<leader>rf", function()
            run.run(vim.fn.expand("%"))
            togglePanel()
        end, { desc = "Run file test" })

        vim.keymap.set("n", "<leader>ra", function()
            run.run({ suite = true })
            togglePanel()
        end, { desc = "Run last test" })
    end
}
