return {

    "mason-org/mason-lspconfig.nvim",
    opts = {
        automatic_enable = {
            exclude = {
                "jdtls"
            }
        },
        ensure_installed = { "lua_ls", "bashls" },
    },
    dependencies = {
        { "neovim/nvim-lspconfig" },
        {
            "mason-org/mason.nvim",
            opts = {
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            }
        },
        {
            "mfussenegger/nvim-jdtls",
        },
        {
            'saghen/blink.cmp',
            dependencies = {
                'rafamadriz/friendly-snippets',
                'neovim/nvim-lspconfig',
                'L3MON4D3/LuaSnip',
                'onsails/lspkind.nvim',
            },
            version = '1.*',
            opts = {
                keymap = {
                    preset = 'default',
                    ['C-h'] = { 'snippet_backward', 'fallback' },
                    ['C-l'] = { 'snippet_forward', 'fallback' },
                },

                appearance = {
                    nerd_font_variant = 'mono',
                },

                completion = {
                    list = {
                        selection = {
                            preselect = true,
                            auto_insert = true,
                        }
                    },
                    trigger = {
                        show_on_trigger_character = true
                    }
                },

                cmdline = {
                    keymap = { preset = 'inherit' },
                    completion = { menu = { auto_show = true } }
                },

                snippets = { preset = 'luasnip' },

                sources = {
                    default = { 'lsp', 'path', 'snippets', 'buffer' },
                }
            }
        },
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
    },
    config = function()
        require("mason-lspconfig").setup()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
                vim.keymap.set('n', '<C-q>', vim.lsp.buf.hover, { desc = "Hover", silent = true })
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename", silent = true })
                vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { desc = "signature_help", silent = true })
                vim.keymap.set({ 'n', 'v' }, '<leader>i', vim.lsp.buf.code_action,
                    { desc = "Code Actions", silent = true })
            end
        })
    end
}
