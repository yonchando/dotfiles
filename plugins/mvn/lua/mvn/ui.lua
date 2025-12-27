local floats = {}

local keymap = function(mode, key, callback)
    vim.keymap.set(mode, key, callback, {
        buffer = floats.bufnr,
        nowait = true,
        silent = true
    })
end

local M = {}

local uv = vim.uv
local spinner_timer = nil;
local spinner_index = 1
local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }

M.start_spinner = function(bufnr, message)
    spinner_timer = uv.new_timer()

    if spinner_timer ~= nil then
        spinner_timer:start(
            0,
            100,
            vim.schedule_wrap(function()
                if not vim.api.nvim_buf_is_valid(bufnr) then
                    return
                end

                spinner_index = spinner_index % #spinner_frames + 1
                local frame = spinner_frames[spinner_index]

                vim.api.nvim_buf_set_lines(bufnr, 0, 1, false, { message .. " " .. frame })
            end)
        )
    end
end

M.stop_spinner = function()
    if spinner_timer then
        spinner_timer:stop()
        spinner_timer:close()
        spinner_timer = nil
    end
end

M.quit = function()
    if CurrentJob then
        CurrentJob:shutdown()
        M.stop_spinner()
    end

    vim.api.nvim_win_close(floats.win, false)
    vim.api.nvim_buf_delete(floats.bufnr, {})
end

---@class OutputConfig
---@field attach_mappings function|nil

---@param opts OutputConfig
M.create_output = function(opts)
    local width = math.floor(vim.o.columns * 0.5)
    local height = math.floor(vim.o.lines * 0.8)
    local win_config = {
        width = width,
        height = height,

        col = (vim.o.columns - width) / 2,
        row = (vim.o.lines - height) / 2,

        relative = 'editor',
        style = "minimal",
        border = "rounded",
    }

    floats.bufnr = vim.api.nvim_create_buf(false, true)

    floats.win = vim.api.nvim_open_win(floats.bufnr, true, win_config)

    vim.api.nvim_set_current_buf(floats.bufnr)

    if opts.attach_mappings == nil then
        keymap('n', 'q', M.quit)
        keymap('n', '<ESC>', M.quit)
    else
        opts.attach_mappings(floats.win, floats.bufnr, keymap)
    end

    return floats
end

return M
