local completion = require("dbdiagram.completion")
--- @module 'blink.cmp'
--- @class blink.cmp.Source
local source = {}

local p = function(value)
    vim.print(vim.inspect(value))
end

local tbl_insert_items = function(values)
    local items = {}
    for _, value in ipairs(values) do
        local item = {
            label = value,
            kind = require("blink.cmp.types").CompletionItemKind.Text,

            inserText = value,
            insertTextFormat = vim.lsp.protocol.InsertTextFormat.PlainText
        }

        table.insert(items, item)
    end

    return items
end

function source.new(opts)
    local self = setmetatable({}, { __index = source })
    self.opts = opts
    return self
end

function source:enabled()
    return vim.bo.filetype == 'dbdiagram' or vim.bo.filetype == 'dbd'
end

function source:get_completions(ctx, callback)
    local items = tbl_insert_items(completion)

    callback({
        items = items,
        is_incomplete_backward = false,
        is_incomplete_forward = false,
    })

    return function()

    end
end

function source:resolve(item, callback)
    item = vim.deepcopy(item)

    item.documentation = {
        kind = 'plaintext',
        value = 'Table {}'
    }

    callback(item)
end

function source:execute(ctx, item, callback, default_implementation)
    default_implementation(ctx, item)

    callback()
end

return source
