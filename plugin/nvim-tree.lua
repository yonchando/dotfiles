local api = require("nvim-tree.api")

local nvim_tree = require("nvim-tree")

-- Run `ng generate` inside the folder under the cursor
-- (or the file's parent folder when the cursor is on a file).
local function ng_generate()
    local node = api.tree.get_node_under_cursor()
    if not node then return end

    local dir
    if node.type == "directory" then
        dir = node.absolute_path
    else
        dir = vim.fn.fnamemodify(node.absolute_path, ":h")
    end

    vim.ui.input({
        prompt = "ng generate (in " .. vim.fn.fnamemodify(dir, ":~:.") .. "): ",
        default = "component ",
    }, function(input)
        if not input or vim.trim(input) == "" then return end

        local ng = vim.fn.executable("ng") == 1 and { "ng" } or { "npx", "ng" }
        local cmd = vim.list_extend(vim.list_extend(ng, { "generate" }), vim.split(vim.trim(input), "%s+"))

        vim.notify("Running: " .. table.concat(cmd, " "), vim.log.levels.INFO)
        vim.system(cmd, { cwd = dir, text = true }, function(res)
            vim.schedule(function()
                if res.code == 0 then
                    vim.notify(res.stdout, vim.log.levels.INFO, { title = "ng generate" })
                    api.tree.reload()
                else
                    vim.notify(res.stderr ~= "" and res.stderr or res.stdout, vim.log.levels.ERROR,
                        { title = "ng generate" })
                end
            end)
        end)
    end)
end

nvim_tree.setup({
    disable_netrw = true,
    view = {
        number = true,
        relativenumber = true,
    },
    renderer = {
        icons = {
            show = {
                git = false
            },
        },
        highlight_git = "name",
        indent_markers = {
            enable = true,
            icons = {
                corner = "└",
                edge = "│",
                item = "│",
                bottom = "─",
                none = " ",
            }
        }
    },
    on_attach = function(bufnr)
        api.map.on_attach.default(bufnr)

        vim.keymap.set("n", "<Esc>", "<C-w>l", { buffer = bufnr })
        vim.keymap.set("n", "<Right>", ":NvimTreeResize +20<CR>", { buffer = bufnr, silent = true })
        vim.keymap.set("n", "<Left>", ":NvimTreeResize -20<CR>", { buffer = bufnr, silent = true })
        vim.keymap.set("n", "<leader>ng", ng_generate,
            { buffer = bufnr, desc = "ng generate in folder under cursor" })
    end
})

local opts = function(tbl)
    return vim.tbl_extend("keep", { noremap = true, silent = true }, tbl)
end

local nvimtreeToggle = function()
    local tree = api.tree

    if tree.is_tree_buf() then
        tree.close()
    else
        tree.open()
    end
end

vim.keymap.set("n", "<leader>gf", function()
    local file = vim.api.nvim_buf_get_name(0)

    api.tree.find_file({
        buf = file,
        open = true,
        focus = true
    })
end, { desc = "Go to current file in nvimtree" })

vim.keymap.set("n", "<A-1>", nvimtreeToggle, opts({ desc = "Explorer toggle" }))
