return {
    "mason-org/mason-lspconfig.nvim",
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
            'nvim-java/nvim-java',
            config = function()
                require('java').setup()
                vim.lsp.enable('jdtls')
            end,
        },
        {
            enabled = false,
            "mfussenegger/nvim-jdtls",
        },
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {},
        },
    },
    config = function()
        local lsp = require("mason-lspconfig")

        lsp.setup({
            automatic_enable = {
                exclude = {
                    "jdtls",
                    "lua_ls"
                }
            },
            ensure_installed = { "lua_ls", "bashls", "hyprls" },
        })

        vim.lsp.config("lua_ls", {
            cmd = { "lua-language-server" },
            filetypes = { 'lua' },
            root_markers = {
                ".luarc.json",
                ".luarc.jsonc",
                ".luacheckrc",
                ".stylua.toml",
                ".git",
            },
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                        path = {
                            '?.lua',
                            '?/init.lua',
                            vim.fn.expand '~/.luarocks/share/lua/5.3/?.lua',
                            vim.fn.expand '~/.luarocks/share/lua/5.3/?/init.lua',
                            '/usr/share/5.4/?.lua',
                            '/usr/share/lua/5.5/?/init.lua',
                            "${2rd}/luv/library"
                        },
                        words = { "vim%.uv" }
                    },
                    completion = {
                        callSnippet = "Replace"
                    },
                    workspace = {
                        library = {
                            vim.fn.expand '~/.luarocks/share/lua/5.3',
                            '/usr/share/lua/5.3'
                        }
                    },
                    globals = {
                        "vim",
                        "describe",
                        "it"
                    },
                    diagnostics = {
                        globals = { "vim" }
                    }
                }
            }
        })
        vim.lsp.enable("lua_ls")

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
