local status_ok, nvimtreesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

nvimtreesitter.setup {
    ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "css",
        "html",
        "javascript",
        "typescript",
        "php",
        "blade"
    },

    sync_install = false,

    auto_install = true,

    highlight = {
        enable = true,

        additional_vim_regex_highlighting = false,
    },

    indent = {
        enable = true,
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm'
        }
    }
}

-- local parser_status_ok, parsers = pcall(require, "nvim-treesitter.parsers")
-- if not parser_status_ok then
--     return
-- end

-- parsers.get_parser_configs().blade = {
--     install_info = {
--         url = "https://github.com/EmranMR/tree-sitter-blade",
--         files = { "src/parser.c" },
--         branch = "main"
--     },
--     filetype = "blade"
-- }

vim.cmd [[
augroup BladeFiltypeRelated
au BufNewFile,BufRead *.blade.php set ft=blade
augroup end
]]
