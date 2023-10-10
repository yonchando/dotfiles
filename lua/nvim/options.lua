vim.g.mapleader = " "
vim.g.EasyMotion_do_mapping = 0
vim.o.shiftwidth = 4
vim.o.relativenumber = true
vim.o.number = true
vim.o.tabstop = 4
vim.o.expandtab = true
vim.loader.enable()
vim.o.smartindent = true
vim.o.mouse = false

vim.cmd [[
autocmd FileType yaml setlocal ts=4 sts=4 sw=4 expandtab
]]

local scheme_exists, _ = pcall(vim.cmd, "colorscheme dracula")
if scheme_exists then
    vim.g.dracula_colorterm = 0
    vim.cmd("colorscheme dracula")
end

-- vim.api.nvim_set_hl(0, "Normal", {guibg = none})

-- code completion highlight color
-- gray
vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', strikethrough = true, fg = '#808080' })
-- blue
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#569CD6' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpIntemAbbrMatch' })
-- light blue
vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = '#9CDCFE' })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
vim.api.nvim_set_hl(0, 'CmpItemKindText', { link = 'CmpItemKindVariable' })
-- pink
vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = '#C586C0' })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
-- front
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = '#D4D4D4' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })

-- yank highlight
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    pattern = '*',
})
