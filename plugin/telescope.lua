local telescope = require("telescope")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local state = require("telescope.actions.state")

telescope.setup({
    pickers = {
        find_files = {
            themes = 'ivy',
            previewer = false,
        },
        git_files = {
            previewer = false,
        },
        oldfiles = {
            previewer = false,
        },
        artisan_routes = {
            previewer = false,
        },
        help_tags = {
            themes = 'ivy',
            mappings = {
                i = {
                    ["<CR>"] = function()
                        actions.select_vertical()
                    end
                },
            },
        }
    },
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
        },
        ['ui-select'] = {
            require("telescope.themes").get_dropdown()
        }
    }
})

require('telescope').load_extension('ui-select')
require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')

local findAll = function()
    builtin.find_files({
        hidden = true,
        no_ignore = true,
    })
end

local recentlyFiles = function()
    builtin.oldfiles({ cwd_only = true })
end

vim.keymap.set('n', '<C-f>', builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set('n', '<C-p>', findAll, { desc = 'Telescope find all files include hidden and git ignore' })
vim.keymap.set('n', '<C-e>', recentlyFiles, { desc = "Recently Files" })

vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set("n", "<leader>dd", builtin.diagnostics, { desc = "Diagnostics" })

vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Lsp Definitions" })
vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "Lsp Implementations" })
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Lsp References" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Lsp References" })
vim.keymap.set("n", "gm", builtin.lsp_document_symbols, { desc = "Lsp Document Symbols" })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)

vim.keymap.set({ 'n', 'v' }, "<leader>i", function()
    vim.lsp.buf.code_action()
end, { desc = "Lsp Auto-Fix / Auto-Import" })

vim.keymap.set({ 'n', 'v' }, "<leader><leader>i", function()
    vim.lsp.buf.code_action({
        context = {
            diagnostics = {},
            only = { "quickfix", "source.fixAll" }
        }
    })
end, { desc = "Lsp quickfix" })

vim.keymap.set({ 'n', 'v' }, "<leader>t", function()
    vim.lsp.buf.code_action({
        context = {
            diagnostics = {},
            only = { "refactor" }
        }
    })
end, { desc = "Lsp quickfix or refactor" })

vim.keymap.set("n", "<C-q>", vim.lsp.buf.hover, { desc = "LSP hover documentation" })

vim.keymap.set("i", "<A-p>", vim.lsp.buf.signature_help, { desc = "LSP signature help" })

-- Angular jump template
local component_url_query

-- Returns the first path of `key` (templateUrl, styleUrl or styleUrls) in @Component
local function get_component_url(bufnr, key)
    component_url_query = component_url_query or vim.treesitter.query.parse("typescript", [[
        (decorator
          (call_expression
            function: (identifier) @_name (#eq? @_name "Component")
            arguments: (arguments
              (object
                (pair
                  key: (property_identifier) @key
                  value: [
                    (string (string_fragment) @url)
                    (array (string (string_fragment) @url))
                  ])))))
    ]])

    local root = vim.treesitter.get_parser(bufnr, "typescript"):parse()[1]:root()

    for _, match in component_url_query:iter_matches(root, bufnr) do
        local found_key, url

        for id, nodes in pairs(match) do
            local name = component_url_query.captures[id]

            if name == "key" then
                found_key = vim.treesitter.get_node_text(nodes[1], bufnr)
            elseif name == "url" then
                url = vim.treesitter.get_node_text(nodes[1], bufnr)
            end
        end

        if found_key == key or (key == "styleUrl" and found_key == "styleUrls") then
            return url
        end
    end
end

local function open_component_url(bufnr, key)
    local url = get_component_url(bufnr, key)

    if url then
        local dir = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
        vim.cmd.edit(vim.fs.normalize(vim.fs.joinpath(dir, url)))
    else
        vim.notify(key .. " not found", vim.log.levels.WARN)
    end
end

-- Finds the component .ts next to a template file
local function open_component_ts(bufnr)
    local path = vim.api.nvim_buf_get_name(bufnr)
    local dir = vim.fs.dirname(path)
    local name = vim.fs.basename(path)
    local ts = vim.fs.joinpath(dir, (name:gsub("%.%w+$", ".ts")))

    if vim.uv.fs_stat(ts) == nil then
        ts = nil

        -- Fall back to a sibling .ts whose @Component references this file
        for file, type in vim.fs.dir(dir) do
            if type == "file" and file:match("%.ts$") and not file:match("%.spec%.ts$") then
                local candidate = vim.fs.joinpath(dir, file)
                local content = table.concat(vim.fn.readfile(candidate), "\n")

                if content:find("./" .. name, 1, true) then
                    ts = candidate
                    break
                end
            end
        end
    end

    if ts then
        vim.cmd.edit(vim.fs.normalize(ts))
    else
        vim.notify("Component file not found", vim.log.levels.WARN)
    end
end

vim.keymap.set("n", "gF", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local ft = vim.bo.filetype

    if ft == 'typescript' then
        open_component_url(bufnr, "templateUrl")
    elseif ft == 'htmlangular' or ft == 'html' then
        open_component_ts(bufnr)
    end
end)
