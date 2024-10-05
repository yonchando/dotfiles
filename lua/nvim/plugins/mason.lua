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
        local util = require 'lspconfig.util'

        vim.keymap.set("n", "<leader>ms", function()
            vim.cmd("Mason")
        end)

        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        local mason_lspconfig = require("mason-lspconfig")

        local servers = mason_lspconfig.get_installed_servers()

        local handler = {
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
        }

        local function get_typescript_server_path(root_dir)
            local global_ts = os.getenv("HOME") .. '/.nvm/versions/node/v22.9.0/lib/node_modules/typescript/lib'
            local found_ts = ''
            local function check_dir(path)
                found_ts = util.path.join(path, 'node_modules', 'typescript', 'lib')
                if util.path.exists(found_ts) then
                    return path
                end
            end
            if util.search_ancestors(root_dir, check_dir) then
                return found_ts
            else
                return global_ts
            end
        end

        local configs = {
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
            emmet_ls = {
                filetypes = {
                    'css',
                    'html',
                    'javascript',
                    'scss',
                    'sass',
                    'vue',
                    'blade',
                },
            },
            lua_ls = {
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
                        },
                        diagnostics = {
                            globals = { "vim" }
                        }
                    }
                }
            },
            bashls = {
                filetypes = {
                    "sh",
                    "zsh",
                }
            },
            html = {
                filetypes = {
                    "html",
                    "blade",
                }
            },
            volar = {
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
                on_new_config = function(new_config, new_root_dir)
                    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
                end,
            },
            ts_ls = {
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = os.getenv("HOME") ..
                                "/.nvm/versions/node/v22.9.0/lib/node_modules/@vue/typescript-plugin",
                            languages = { "javascript", "typescript", "vue" },
                        }
                    }
                },
                filetypes = {
                    "javascript",
                    "typescript",
                    "vue",
                },
            }
        }

        for _, value in pairs(servers) do
            handler[value] = function()
                lspconfig[value].setup { configs[value] }
            end
        end

        mason_lspconfig.setup({
            ensure_installed = {
                "lua_ls",
                "bashls"
            },
            automatic_installation = false,
            handlers = handler,
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
