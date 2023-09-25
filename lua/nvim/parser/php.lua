local treesitter_status, parsers = pcall(require, "nvim-treesitter.parsers")
if not treesitter_status then
    return
end

local treesitter = vim.treesitter
local cconfigs = require("nvim-treesitter.configs")
local namespace = vim.api.nvim_create_namespace("phpblade")

local p = function(value)
    print(vim.inspect(value))
end

local t = function(node)
    p(treesitter.get_node_text(node, 0))
end

local M = {}

M.queries = {
    method_name = [[
        (class_declaration
          (declaration_list
            (method_declaration
              (name) @methodName
            )
          )
        )
    ]],
    class_name = [[ 
        (class_declaration
          (name) @className
        )
    ]]
}

M.colors = {
    method_name = "#FFC66D",
    class_name = "#FFFFFF",
}

M.highlight = function(name,qs)
    local bufnr = vim.api.nvim_get_current_buf()
    local query = treesitter.query.parse('php', qs)
    local parser = parsers.get_parser(bufnr, "php")
    local tree = parser:parse()[1]
    local root = tree:root()

    local highligh_tree = function(root_tree, cap_start, cap_end)
        vim.api.nvim_buf_clear_namespace(bufnr, namespace, cap_start, cap_end)
        for id, matches, _ in query:iter_matches(root_tree, bufnr, cap_start, cap_end) do
            local node = matches[1]
            local start_row, start_col, end_row, end_col = node:range()
            local range_start = { start_row, start_col }
            local range_end = { end_row, end_col }

            local group_name = "custom_" .. name
            vim.api.nvim_set_hl(0, group_name, { fg = M.colors[name]})
            -- vim.highlight.create(group_name, { guifg = "#FFC66D" })

            t(node)

            vim.highlight.range(
                bufnr,
                namespace,
                group_name,
                range_start,
                range_end
            )
        end
    end

    highligh_tree(root, 0, -1)
    parser:register_cbs({
        on_changedtree = function(change, changetree)
            highligh_tree(changetree:root(), 0, -1)
        end
    })
end

M.setup = function()
    for name, qs in pairs(M.queries) do
        M.highlight(name,qs)
    end
end


-- parsers.get_parser_configs().blade = {
--     install_info = {
--         url = "https://github.com/EmranMR/tree-sitter-blade",
--         files = { "src/parser.c" },
--         branch = "main"
--     },
--     filetype = "blade"
-- }

-- vim.cmd [[
-- augroup BladeFiltypeRelated
-- au BufNewFile,BufRead *.blade.php set ft=blade
-- augroup end
-- ]]
--
return M
