return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "onsails/lspkind.nvim",
        "neovim/nvim-lspconfig",
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
            dependencies = {
                "rafamadriz/friendly-snippets",
            }
        },
        "saadparwaiz1/cmp_luasnip",
        {
            "dcampos/cmp-emmet-vim",
            dependencies = {
                "mattn/emmet-vim",
            }
        },
        "roobert/tailwindcss-colorizer-cmp.nvim"
    },
    config = function()
        local luasnip = require("luasnip")

        require("luasnip.loaders.from_snipmate").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load()

        luasnip.config.setup({})

        vim.keymap.set({ "i" }, "<C-K>", function() luasnip.expand() end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-L>", function() luasnip.jump(1) end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-J>", function() luasnip.jump(-1) end, { silent = true })

        vim.keymap.set({ "i", "s" }, "<C-E>", function()
            if luasnip.choice_active() then
                luasnip.change_choice(1)
            end
        end, { silent = true })

        local cmp = require("cmp")
        local lspkind = require('lspkind')

        local M = {
            view = {
                entries = "custom"
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                    --vim.snippet.expand(args.body)
                end,
            },
            window = {
                completion = {
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                    col_offset = -3,
                    side_padding = 0,
                },
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
                ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
                ['<C-Space>'] = cmp.mapping.complete({
                    config = {
                        sources = {
                            { name = 'nvim_lsp' },
                            { name = "emmet_vim" },
                            { name = "buffer" },
                        }
                    }
                }),
                ['<C-j>'] = cmp.mapping.complete({
                    config = {
                        sources = {
                            { name = 'luasnip' }
                        }
                    }
                }),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = "buffer" },
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "emmet_vim" },
            }),
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = lspkind.cmp_format({
                    mode = 'symbol_text',
                    menu = ({
                        buffer = "[Buffer]",
                        nvim_lsp = "[LSP]",
                        luasnip = "[LuaSnip]",
                        nvim_lua = "[Lua]",
                        latex_symbols = "[Latex]",
                        tailwindcss_colors = "[Colors]"
                    }),
                    maxwidth = 50,
                    ellipsis_char = '...',

                    before = function(_, vim_item)
                        local cmp_kinds = {
                            Text = '  ',
                            Method = '  ',
                            Function = '  ',
                            Constructor = '  ',
                            Field = '  ',
                            Variable = '  ',
                            Class = '  ',
                            Interface = '  ',
                            Module = '  ',
                            Property = '  ',
                            Unit = '  ',
                            Value = '  ',
                            Enum = '  ',
                            Keyword = '  ',
                            Snippet = '  ',
                            Color = '  ',
                            File = '  ',
                            Reference = '  ',
                            Folder = '  ',
                            EnumMember = '  ',
                            Constant = '  ',
                            Struct = '  ',
                            Event = '  ',
                            Operator = '  ',
                            TypeParameter = '  ',
                        }
                        vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
                        return vim_item
                    end
                })
            }
        }
        -- nvim-cmp setup
        cmp.setup(M)

        -- tailwindcss colorizer
        cmp.config.formatting = {
            format = require("tailwindcss-colorizer-cmp").formatter
        }

        -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
            }, {
                { name = 'buffer' },
            })
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })
    end
}
