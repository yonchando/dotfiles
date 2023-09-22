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
        'bashls',
        'clangd',
        'rust_analyzer',
        'lemminx',
        'jdtls',
    },
    automatic_installation = {
        exclude = {"jdtls"},
    },
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
    clangd = {},
    bashls = {
        filetypes = {
            "sh",
            "zsh",
        }
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
    },
    lemminx = {},
    rust_analyzer = {},
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

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = "Diagnostic open float" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to prev Diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next Diagnostic" })
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { desc = "Open Diagnostic lists" })

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function()
        vim.keymap.set('n', '<C-q>', vim.lsp.buf.hover, { desc = "Hover" })
        vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help, { desc = "[S]ignature [H]elp" })
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, { desc = "Type Definition" })
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { desc = "Rename" })
        vim.keymap.set({ 'n', 'v' }, '<space>i', vim.lsp.buf.code_action, { desc = "Code Actions" })
        vim.keymap.set('n', '<space>fc', function()
            vim.lsp.buf.format { async = true }
        end, { desc = "Reformat code" })
    end,
})
