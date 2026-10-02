local tree = require("nvim-treesitter")

tree.setup({
    install_dir = vim.fn.stdpath('data') .. '/site'
})

tree.install({
    "vim", "lua", "bash", "regex", "vimdoc", "markdown", "markdown_inline",
    "html", "css", "javascript", "typescript",
    "http", "json", "xml", "yaml",
    "java", "javadoc",
    "angular",
    "php",
    "hyprlang",
    "rasi",
    "zsh",
    "go"
})

vim.treesitter.language.register("angular", "htmlangular")

for _, value in pairs(tree.get_installed()) do
    vim.api.nvim_create_autocmd('FileType', {
        pattern = vim.treesitter.language.get_filetypes(value),
        callback = function()
            vim.treesitter.start()
            vim.wo[0][0].foldmethod = "expr"
            vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
    })
end

local textobj = require("nvim-treesitter-textobjects")

textobj.setup({
    select = {
        selection_modes = {
            ['@parameter.outer'] = 'v',
            ['@function.outer'] = 'v',
        }
    }
})

local text_select = require("nvim-treesitter-textobjects.select")

local text_object_mapping = {
    ['af'] = '@function.outer',
    ['if'] = '@function.inner',
    ['aa'] = '@parameter.outer',
    ['ia'] = '@parameter.inner',
    ['ac'] = '@class.outer',
    ['ic'] = '@class.inner',
}

for key, value in pairs(text_object_mapping) do
    vim.keymap.set({ "x", "o" }, key, function()
        text_select.select_textobject(value, "textobjects")
    end, {
        desc = "Select " .. value
    })
end
