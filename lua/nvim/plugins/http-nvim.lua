return {
    dir = "/mnt/d/code/lua/http.nvim",
    enabled = true,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        vim.cmd [[
augroup ReqFiltypeRelated
  au BufNewFile,BufRead *.http set ft=http
augroup END
]]
    end
}
