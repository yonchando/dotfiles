return {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets', 'neovim/nvim-lspconfig' },

    version = '1.*',

    opts = {
        keymap = { preset = 'default' },

        appearance = {
            nerd_font_variant = 'mono'
        },

        completion = {
            list = {
                selection = {
                    preselect = false,
                    auto_insert = true,
                }
            }
        }
    },

}
