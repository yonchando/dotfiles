return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local status_ok, lspconfig = pcall(require, "lspconfig")
        if not status_ok then
            return
        end

        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        local servers = {
            cssls = {},
            jsonls = {},
            tsserver = {},
            tailwindcss = {},
            angularls = {},
            clangd = {},
            volar = {},
            yamlls = {},
            lemminx = {},
            rust_analyzer = {},
            gopls = {},
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
                -- vim.keymap.set('n', '<space>fc', function()
                --     vim.lsp.buf.format { async = true }
                -- end, { desc = "Reformat code" })
            end,
        })
    end
}