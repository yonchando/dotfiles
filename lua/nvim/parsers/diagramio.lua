local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config['dbml'] = {
    install_info = {
        url = "https://github.com/yonchando/tree-sitter-dbdiagram", -- local path or git repo
        -- url = "/mnt/d/code/treesitter/tree-sitter-dbdiagram",
        files = { "src/parser.c" },                                 -- note that some parsers also require src/scanner.c or src/scanner.cc
        branch = "main",                                            -- default branch in case of git repo if different from master
        generate_requires_npm = false,                              -- if stand-alone parser without npm dependencies
        requires_generate_from_grammar = false,                     -- if folder contains pre-generated src/parser.c
    },
    filetype = "dbml",                                              -- if filetype does not match the parser name
}

vim.filetype.add({
    extension = {
        dbml = 'dbml'
    }
})
