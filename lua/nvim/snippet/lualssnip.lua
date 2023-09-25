local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local snippet = ls.snippet
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node

ls.add_snippets('lua', {
    snippet("$", {
        text("local "),
        insert(1, "setup"),
        text(" = "),
        insert(2, "value")
    }),
    snippet("mod", {
        text("local M = {}"),
    })
})

ls.add_snippets("php", {
    snippet("pubf", {
        text("public function "),
        insert(1, "name"),
        text("("),
        insert(2, "$params"),
        text(")"),
        text({"{"}),
        insert(0, {""}),
        text({"}"})
    })
})
