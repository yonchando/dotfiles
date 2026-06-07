local tree = require("nvim-treesitter")

tree.setup({
    install_dir = vim.fn.stdpath('data') .. '/site'
})

tree.install({
    "lua", "bash", "regex", "vimdoc",
    "html", "javascript", "typescript",
    "http", "json", "xml", "yaml",
    "java", "javadoc",
    "angular",
    "php",
    "hyprlang",
    "rasi",
    "zsh",
    "go"
})

for _, value in pairs(tree.get_installed()) do
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { value },
      callback = function() vim.treesitter.start() end,
    })
end
