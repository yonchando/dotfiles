local lualine = require("lualine")


lualine.setup({
    options = {
        icons_enabled = true,
        theme = 'tokyonight',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
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
            'encoding',
            'fileformat',
            { 'filetype', colored = false, icon_only = false }
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
    },
})

