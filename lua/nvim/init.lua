require("nvim.options")
require("nvim.remap")
local packer = require("nvim.packer")
if packer then
    require("nvim.plugin")
end

vim.opt.termguicolors = true
require("bufferline").setup{}
