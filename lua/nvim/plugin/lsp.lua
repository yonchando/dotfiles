local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    return
end

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
        "html",
        "cssls",
        "tsserver",
        "intelephense",
        'angularls',
        'volar',
        'jsonls',
        'tailwindcss',
        'emmet_ls',
    },
    automatic_installation = false,
    handlers = nil,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
    html = {},
    cssls = {},
    jsonls = {},
    tsserver = {},
    tailwindcss = {},
    intelephense = {},
    angularls = {},
    emmet_ls = {
        filetypes = {
            'css',
            'html',
            'javascript',
            'scss',
            'sass',
            'vue',
            'php',
            'blade',
        },
    },
    volar = {},
    lua_ls = {
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Both"
                },
                workspace = {
                    checkThirdParty = false,
                }
            }
        }
    }
}

for lsp, config in pairs(servers) do
    config.capabilities = capabilities
    -- config.capabilities.textDocument.completion.completionItem.snippetSupport = true
    lspconfig[lsp].setup(config)
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
        ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
        -- C-b (back) C-f (forward) for snippet placeholder navigation.
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'emmet_vim' },
    },
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

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = "Diagnostic open float" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to prev Diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next Diagnostic" })
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { desc = "Open Diagnostic lists" })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function()
        -- Enable completion triggered by <c-x><c-o>
        -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        vim.keymap.set('n', '<C-q>', vim.lsp.buf.hover, { desc = "Hover" })
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "Signature Help" })
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, { desc = "Type Definition" })
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { desc = "Rename" })
        vim.keymap.set({ 'n', 'v' }, '<space>i', vim.lsp.buf.code_action, { desc = "Code Actions" })
        vim.keymap.set('n', '<space>fc', function()
            vim.lsp.buf.format { async = true }
        end, { desc = "Reformat code" })
    end,
})
