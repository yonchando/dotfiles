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
    intelephense = {}
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
                callSnippet = "Both"
            },
            workspace = {
                checkThirdParty = false,
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

        vim.keymap.set('n', '<C-q>', vim.lsp.buf.hover, { desc = "Hover" })
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { desc = "Rename" })
        vim.keymap.set({ 'n', 'v' }, '<space>i', vim.lsp.buf.code_action, { desc = "Code Actions" })
        vim.keymap.set('n', '<space>fc', function()
            vim.lsp.buf.format { async = true }
        end, { desc = "Reformat code" })
    end,
})
