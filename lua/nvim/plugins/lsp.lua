return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "dcampos/cmp-emmet-vim" },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        local servers = {
            cssls = {},
            jsonls = {},
            tailwindcss = {},
            angularls = {},
            clangd = {},
            volar = {},
            yamlls = {
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
            },
            lemminx = {},
            rust_analyzer = {},
            gopls = {},
            tsserver = {},
            asm_lsp = {},
        }

        servers.intelephense = {
            stubs = {
                "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype", "curl", "date",
                "dba", "dom", "enchant", "exif", "FFI", "fileinfo", "filter", "fpm", "ftp", "gd", "gettext",
                "gmp", "hash", "iconv", "imap", "intl", "json", "ldap", "libxml", "mbstring", "meta", "mysqli",
                "oci8", "odbc", "openssl", "pcntl", "pcre", "PDO", "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite",
                "pgsql",
                "Phar", "posix", "pspell", "readline", "Reflection", "session", "shmop", "SimpleXML", "snmp", "soap",
                "sockets", "sodium", "SPL", "sqlite3", "standard", "superglobals", "sysvmsg", "sysvsem", "sysvshm",
                "tidy",
                "tokenizer", "xml", "xmlreader", "xmlrpc", "xmlwriter", "xsl", "Zend OPcache", "zip", "zlib",
                "wordpress", "phpunit",
            },
        }

        servers.html = {
            filetypes = {
                "html",
                "blade",
            }
        }

        servers.emmet_ls = {
            filetypes = {
                'css',
                'html',
                'javascript',
                'scss',
                'sass',
                'vue',
                'blade',
            },
        }

        servers.lua_ls = {
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

        }

        servers.bashls = {
            filetypes = {
                "sh",
                "zsh",
            }
        }

        for lsp, config in pairs(servers) do
            capabilities.textDocument = {
                completion = {
                    completionItem = {
                        snipetSupport = true
                    }
                }
            }
            config.capabilities = capabilities

            lspconfig[lsp].setup(config)
        end

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
