return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "dcampos/cmp-emmet-vim",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer"
            },
            automatic_installation = false,
            handlers = {
                function(server_name)
                    capabilities.textDocument = {
                        completion = {
                            completionItem = {
                                snipetSupport = true
                            }
                        }
                    }

                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities
                    });
                end,

                ['yamlls'] = function()
                    lspconfig.lua_ls.setup({
                        settings = {
                            yaml = {
                                schemas = {
                                    ["https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json"] =
                                    "/aws.yaml",
                                    ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
                                    "/docker-compose.yaml"
                                }
                            }
                        },
                    })
                end,

                ['intelephense'] = function()
                    lspconfig.intelephense.setup({
                        stubs = {
                            "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype", "curl", "date",
                            "dba", "dom", "enchant", "exif", "FFI", "fileinfo", "filter", "fpm", "ftp", "gd", "gettext",
                            "gmp", "hash", "iconv", "imap", "intl", "json", "ldap", "libxml", "mbstring", "meta",
                            "mysqli",
                            "oci8", "odbc", "openssl", "pcntl", "pcre", "PDO", "pdo_ibm", "pdo_mysql", "pdo_pgsql",
                            "pdo_sqlite",
                            "pgsql",
                            "Phar", "posix", "pspell", "readline", "Reflection", "session", "shmop", "SimpleXML", "snmp",
                            "soap",
                            "sockets", "sodium", "SPL", "sqlite3", "standard", "superglobals", "sysvmsg", "sysvsem",
                            "sysvshm",
                            "tidy",
                            "tokenizer", "xml", "xmlreader", "xmlrpc", "xmlwriter", "xsl", "Zend OPcache", "zip", "zlib",
                            "wordpress", "phpunit",
                        },
                    })
                end,

                ['emmet_ls'] = function()
                    lspconfig.emmet_ls.setup({
                        filetypes = {
                            'css',
                            'html',
                            'javascript',
                            'scss',
                            'sass',
                            'vue',
                            'blade',
                        },
                    })
                end,

                ['lua_ls'] = function()
                    lspconfig.lua_ls.setup({

                        settings = {
                            Lua = {
                                completion = {
                                    callSnippet = "Replace"
                                },
                                workspace = {
                                    checkThirdParty = false,
                                },
                                globals = {
                                    "vim",
                                    "describe",
                                    "it"
                                }
                            }
                        }
                    })
                end,

                ['bashls'] = function()
                    lspconfig.bashls.setup({
                        filetypes = {
                            "sh",
                            "zsh",
                        }
                    })
                end,

                ['html'] = function()
                    lspconfig.html.setup({
                        filetypes = {
                            "html",
                            "blade",
                        }
                    })
                end,

                ['gopls'] = function()
                    lspconfig.gopls.setup {}
                end
            },
        })

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                vim.keymap.set('n', '<C-q>', vim.lsp.buf.hover, { desc = "Hover", silent = true })
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { desc = "Rename", silent = true })
                vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { desc = "signature_help", silent = true })
                vim.keymap.set({ 'n', 'v' }, '<space>i', vim.lsp.buf.code_action,
                    { desc = "Code Actions", silent = true })
            end,
        })
    end
}
