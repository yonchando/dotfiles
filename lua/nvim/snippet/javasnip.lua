local ls = require("luasnip")

local fmt = require("luasnip.extras.fmt").fmt
local snippet = ls.snippet
local text = ls.text_node
local insert_node = ls.insert_node
local func = ls.function_node

ls.add_snippets("java", {
    snippet("sout", {
        text("System.out.println("),
        insert_node(1, "e"),
        text(");")
    })
})
