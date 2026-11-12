local mason = vim.fn.stdpath('data') .. "/mason/packages"

local paths = {
    -- root dir containing plugins/ and config_linux/
    jdtls = mason .. "/jdtls",
    lombok = mason .. "/jdtls/lombok.jar",
    -- extension dir containing jars/ and language-server/
    spring_boot_tools = mason .. "/vscode-spring-boot-tools/extension",
    jdk = "/usr/lib/jvm/default",
}

local missing = {}
for name, path in pairs(paths) do
    if not vim.uv.fs_stat(path) then
        table.insert(missing, name .. " (" .. path .. ")")
    end
end

if next(missing) then
    vim.schedule(function()
        vim.notify(
            "nvim-java skipped, missing:\n  " .. table.concat(missing, "\n  ")
            .. "\nRun :SetupServer java",
            vim.log.levels.WARN
        )
    end)
    return
end

require("java").setup({
    jdtls = {
        path = paths.jdtls,
        auto_install = false,
    },
    java_test = {
        enable = false,
    },
    java_debug_adapter = {
        enable = false,
    },
    lombok = {
        path = paths.lombok,
        auto_install = false,
    },
    spring_boot_tools = {
        path = paths.spring_boot_tools,
        auto_install = false,
    },
    jdk = {
        path = paths.jdk,
        auto_install = false,
    },
})
