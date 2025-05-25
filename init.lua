require("nvim")

local ok, folding = pcall(require, "folding")

if ok then
    folding.setup()
end
