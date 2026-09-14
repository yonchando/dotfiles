local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup({
    keymap = { preset = 'default' },
    cmdline = { enabled = true },
    completion = {
        keyword = { range = 'prefix' },

        accept = { auto_brackets = { enabled = false }, },

        list = { selection = { preselect = false, auto_insert = true } },

        menu = {
            auto_show = false,

            draw = {
                columns = {
                    { "label",     "label_description", gap = 1 },
                    { "kind_icon", "kind" }
                },
            }
        },
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
        ghost_text = { enabled = true },
    },

})
