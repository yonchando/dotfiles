return {
    'nvim-lualine/lualine.nvim',
    opts = {
        options = {
            icons_enabled = true,
            theme = 'tokyonight',
            component_separators = { left = '<', right = '<' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            }
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch' },
            lualine_c = {
                {
                    'filename',
                    path = 1,
                    file_status = false,
                }
            },
            lualine_x = {
                -- {
                --     require("noice").api.status.command.get,
                --     cond = require("noice").api.status.command.has,
                --     color = { fg = "#ff9e64" },
                -- },
                'encoding',
                'fileformat',
                { 'filetype', colored = false, icon_only = false }
            },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    },
    dependencies = {
        {
            'nvim-tree/nvim-web-devicons',
            lazy = true,
        },
        {
            "folke/tokyonight.nvim",
            lazy = false,
            priority = 1000,
            opts = {
                style = "moon",
                transparent = true,
                terminal_colors = true,
                styles = {
                    comments = { italic = true },
                    keywords = { italic = true },
                    floats = "dark",
                }
            },
            config = function(_, opts)
                local tokyonight = require('tokyonight')
                tokyonight.setup(opts)
                vim.cmd [[colorscheme tokyonight]]
            end
        }

    },
}
