local status, _ = pcall(require, "luasnip")

if not status then
    return
end

require("nvim.snippet.luasnip")
require("nvim.snippet.phpsnip")
require("nvim.snippet.javasnip")
