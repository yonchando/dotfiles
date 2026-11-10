local api = require("nvim-tree.api")

local nvim_tree = require("nvim-tree")

local NG_SCHEMATICS = {
    "component", "service", "directive", "pipe", "guard", "interceptor",
    "resolver", "module", "class", "interface", "enum", "environments",
    "library", "application", "web-worker", "service-worker", "app-shell", "config",
}

local function ng_run(dir, args)
    local ng = vim.fn.executable("ng") == 1 and { "ng" } or { "npx", "ng" }
    local cmd = vim.list_extend(vim.list_extend(ng, { "generate" }), args)

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
end

local function ng_prompt_name(dir, schematic)
    vim.ui.input({ prompt = "ng g " .. schematic .. " name: " }, function(input)
        if not input or vim.trim(input) == "" then return end
        ng_run(dir, vim.list_extend({ schematic }, vim.split(vim.trim(input), "%s+")))
    end)
end

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

    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local themes = require("telescope.themes")

    pickers.new(themes.get_dropdown({}), {
        prompt_title = "ng generate (" .. vim.fn.fnamemodify(dir, ":~:.") .. ")",
        finder = finders.new_table({ results = NG_SCHEMATICS }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                local entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                if entry then
                    vim.schedule(function() ng_prompt_name(dir, entry[1]) end)
                end
            end)
            return true
        end,
    }):find()
end

-- Open node; when closing an open directory, collapse all its descendants too,
-- so re-expanding it later shows children collapsed.
local function open_or_collapse()
    local node = api.tree.get_node_under_cursor()
    if node and node.type == "directory" and node.open then
        api.node.collapse(node)
    else
        api.node.open.edit()
    end
end

-- Like default <BS> (close parent), but collapses the parent recursively.
local function parent_collapse()
    local node = api.tree.get_node_under_cursor()
    if not node then return end
    local parent = node.parent
    -- skip the root (no parent) so <BS> never collapses the whole tree
    if parent and parent.parent then
        api.node.collapse(parent)
    else
        api.node.navigate.parent_close()
    end
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

        local o = function(desc) return { buffer = bufnr, noremap = true, silent = true, nowait = true, desc = desc } end
        vim.keymap.set("n", "<CR>", open_or_collapse, o("Open / collapse recursively"))
        vim.keymap.set("n", "o", open_or_collapse, o("Open / collapse recursively"))
        vim.keymap.set("n", "<2-LeftMouse>", open_or_collapse, o("Open / collapse recursively"))
        vim.keymap.set("n", "<BS>", parent_collapse, o("Close parent recursively"))

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
