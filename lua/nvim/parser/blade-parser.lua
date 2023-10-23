local status, parser = pcall(require, "nvim-treesitter.parsers")

if not status then
    return
end

local parser_config = parser.get_parser_configs()

parser_config.blade = {
    install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = { "src/parser.c" },
        branch = "main",
    },
    filetype = "blade"
}

vim.api.nvim_set_hl(0, "@directive", { link = "Function" })

vim.cmd [[
augroup BladeFiltypeRelated
  au BufNewFile,BufRead *.blade.php set ft=blade
augroup END
]]
