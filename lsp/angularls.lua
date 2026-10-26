local component_url_query

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

local component_key_query

-- Finds the key node of a @Component property (e.g. inline `template`)
local function get_component_key_node(bufnr, key)
    component_key_query = component_key_query or vim.treesitter.query.parse("typescript", [[
        (decorator
          (call_expression
            function: (identifier) @_name (#eq? @_name "Component")
            arguments: (arguments
              (object
                (pair
                  key: (property_identifier) @key)))))
    ]])

    local root = vim.treesitter.get_parser(bufnr, "typescript"):parse()[1]:root()

    for id, node in component_key_query:iter_captures(root, bufnr) do
        if component_key_query.captures[id] == "key" and vim.treesitter.get_node_text(node, bufnr) == key then
            return node
        end
    end
end

local function open_component_url(bufnr, key)
    local url = get_component_url(bufnr, key)

    if url then
        local dir = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
        vim.cmd.edit(vim.fs.normalize(vim.fs.joinpath(dir, url)))
        return
    end

    -- Inline template: jump to the `template` key instead
    local inline_key = key == "templateUrl" and "template" or (key == "styleUrl" and "styles")
    local node = inline_key and get_component_key_node(bufnr, inline_key)

    if node then
        local row, col = node:range()
        vim.cmd("normal! m'")
        vim.api.nvim_win_set_cursor(0, { row + 1, col })
    else
        vim.notify(key .. " not found", vim.log.levels.WARN)
    end
end

-- Finds the component .ts next to a template file
local function open_component_ts(bufnr)
    local path = vim.api.nvim_buf_get_name(bufnr)
    local dir = vim.fs.dirname(path)
    local name = vim.fs.basename(path)
    local same_name = vim.fs.joinpath(dir, (name:gsub("%.%w+$", ".ts")))

    ---@type string?
    local ts

    if vim.uv.fs_stat(same_name) then
        ts = same_name
    else
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

-- Position inside the component class, which angularls needs to find the component
local function get_class_position(bufnr)
    local root = vim.treesitter.get_parser(bufnr, "typescript"):parse()[1]:root()
    local cursor_row = vim.api.nvim_win_get_cursor(0)[1] - 1
    local first

    for node in root:iter_children() do
        local class = node:type() == "export_statement" and node:field("declaration")[1] or node

        if class and class:type() == "class_declaration" then
            local start_row, _, end_row = class:range()

            if cursor_row >= start_row and cursor_row <= end_row then
                return { line = cursor_row, character = 0 }
            end

            first = first or { line = start_row, character = 0 }
        end
    end

    return first
end

local function jump_to_location(location, client)
    vim.cmd("normal! m'")
    vim.lsp.util.show_document(location, client.offset_encoding, { focus = true })
end

-- Asks angularls first, then falls back to treesitter/file search
local function lsp_request(bufnr, method, params, on_result, fallback)
    local client = vim.lsp.get_clients({ bufnr = bufnr, name = "angularls" })[1]

    if not client then
        return fallback()
    end

    client:request(method, params, function(err, result)
        if err or result == nil or (vim.islist(result) and #result == 0) then
            fallback()
        else
            on_result(result, client)
        end
    end, bufnr)
end

local function go_to_template(bufnr)
    local fallback = function() open_component_url(bufnr, "templateUrl") end
    local position = get_class_position(bufnr)

    if not position then
        return fallback()
    end

    lsp_request(bufnr, "angular/getTemplateLocationForComponent", {
        textDocument = vim.lsp.util.make_text_document_params(bufnr),
        position = position,
    }, function(location, client)
        -- Inline template: prefer landing on the `template` key
        if vim.uri_to_bufnr(location.uri) == bufnr then
            return fallback()
        end

        jump_to_location(location, client)
    end, fallback)
end

local function go_to_component(bufnr)
    lsp_request(bufnr, "angular/getComponentsWithTemplateFile", {
        textDocument = vim.lsp.util.make_text_document_params(bufnr),
    }, function(locations, client)
        if #locations == 1 then
            return jump_to_location(locations[1], client)
        end

        vim.ui.select(locations, {
            prompt = "Component",
            format_item = function(location)
                return vim.fn.fnamemodify(vim.uri_to_fname(location.uri), ":~:.")
            end,
        }, function(location)
            if location then
                jump_to_location(location, client)
            end
        end)
    end, function() open_component_ts(bufnr) end)
end

-- Opens the generated type-check block for the template at cursor, highlighting the matching code
local function show_tcb(bufnr)
    local client = vim.lsp.get_clients({ bufnr = bufnr, name = "angularls" })[1]

    if not client then
        return vim.notify("angularls is not attached", vim.log.levels.WARN)
    end

    -- Custom angularls method, not in the typed list of LSP methods
    ---@diagnostic disable-next-line: param-type-mismatch
    client:request("angular/getTcb", vim.lsp.util.make_position_params(0, client.offset_encoding), function(err, result)
        if err or not result then
            return vim.notify("No type-check block at cursor", vim.log.levels.WARN)
        end

        local tcb_buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(tcb_buf, 0, -1, false, vim.split(result.content, "\n"))
        vim.bo[tcb_buf].filetype = "typescript"
        vim.bo[tcb_buf].bufhidden = "wipe"
        vim.bo[tcb_buf].modifiable = false

        vim.cmd.vsplit()
        vim.api.nvim_win_set_buf(0, tcb_buf)

        local ns = vim.api.nvim_create_namespace("angular_tcb")

        for _, range in ipairs(result.selections) do
            vim.hl.range(tcb_buf, ns, "Visual",
                { range.start.line, range.start.character },
                { range["end"].line, range["end"].character })
        end

        local first = result.selections[1]

        if first then
            vim.api.nvim_win_set_cursor(0, { first.start.line + 1, first.start.character })
            vim.cmd("normal! zz")
        end
    end, bufnr)
end

vim.api.nvim_create_user_command("NgTcb", function()
    show_tcb(vim.api.nvim_get_current_buf())
end, { desc = "Show Angular type-check block for the template at cursor" })

local progress_id

local function echo_progress(message, status)
    progress_id = vim.api.nvim_echo({ { message } }, false, {
        id = progress_id,
        kind = "progress",
        status = status,
        title = "angularls",
        source = "angularls",
    })
end

vim.keymap.set("n", "gF", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local ft = vim.bo.filetype

    if ft == 'typescript' then
        go_to_template(bufnr)
    elseif ft == 'htmlangular' or ft == 'html' then
        go_to_component(bufnr)
    end
end)


return {
    -- Only start inside Angular projects (angular.json / nx.json)
    workspace_required = true,
    handlers = {
        ["angular/projectLoadingStart"] = function()
            echo_progress("Loading project", "running")
        end,
        ["angular/projectLoadingFinish"] = function()
            echo_progress("Project loaded", "success")
            progress_id = nil
        end,
    },
    commands = {
        -- Sent with completions that need edits in other files (e.g. auto-import into the component)
        ["angular.applyCompletionCodeAction"] = function(command, ctx)
            local client = assert(vim.lsp.get_client_by_id(ctx.client_id))

            for _, edit in ipairs(command.arguments[1] or {}) do
                vim.lsp.util.apply_workspace_edit(edit, client.offset_encoding)
            end
        end,
    }
}
