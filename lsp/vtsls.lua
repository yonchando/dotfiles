local inlay_hints = {
    parameterNames = { enabled = "literals" },
    functionLikeReturnTypes = { enabled = true },
    enumMemberValues = { enabled = true },
}

local function source_action(kind)
    return function()
        vim.lsp.buf.code_action({
            apply = true,
            context = {
                diagnostics = {},
                only = { kind },
            },
        })
    end
end

--- @type vim.lsp.Config
return {
    settings = {
        vtsls = {
            -- Use the project's TypeScript (same version angularls loads)
            autoUseWorkspaceTsdk = true,
            experimental = {
                completion = {
                    enableServerSideFuzzyMatch = true,
                    entriesLimit = 200,
                },
            },
        },
        typescript = { inlayHints = inlay_hints },
        javascript = { inlayHints = inlay_hints },
    },
    commands = {
        -- Telemetry hook sent after organize/remove unused imports, nothing to do
        ["_typescript.didOrganizeImports"] = function() end,
    },
    on_attach = function(_, bufnr)
        local function map(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("<leader>ai", source_action("source.addMissingImports.ts"), "Add missing imports")
        map("<leader>ru", source_action("source.removeUnusedImports"), "Remove unused imports")
        map("<leader>op", source_action("source.organizeImports"), "Organize imports")
        map("<leader>h", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
        end, "Toggle inlay hints")
    end,
}
