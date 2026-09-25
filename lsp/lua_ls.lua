-- Function to gather all paths from your vim pack structure
local function get_pack_libraries()
    local libs = { vim.env.VIMRUNTIME }

    -- Find all 'lua' directories within your packpath hierarchy
    local pack_lua_paths = vim.api.nvim_get_runtime_file("pack/*/start/*/lua", true)
    local opt_lua_paths = vim.api.nvim_get_runtime_file("pack/*/opt/*/lua", true)

    -- Merge them into the library list
    for _, path in ipairs(pack_lua_paths) do
        table.insert(libs, path)
    end
    for _, path in ipairs(opt_lua_paths) do
        table.insert(libs, path)
    end

    return libs
end

return {
    root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        ".git",
    },
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath('config')
                and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                version = 'LuaJIT',
                path = {
                    'lua/?.lua',
                    'lua/?/init.lua',
                },
            },
            workspace = {
                checkThirdParty = false,
                library = get_pack_libraries(),
            },
        })
    end,
    settings = {
        Lua = {},
    },
}
