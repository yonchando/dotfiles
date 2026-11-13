local mason = vim.fn.stdpath('data') .. "/mason/packages"

local paths = {
    -- root dir containing plugins/ and config_linux/
    jdtls = mason .. "/jdtls",
    lombok = mason .. "/jdtls/lombok.jar",
    jdk = "/usr/lib/jvm/default",
}

local missing = {}
for name, path in pairs(paths) do
    if not vim.uv.fs_stat(path) then
        table.insert(missing, name .. " (" .. path .. ")")
    end
end

if next(missing) then
    return
end

local optional = {
    spring_boot_tools = mason .. "/vscode-spring-boot-tools/extension",
    java_test = mason .. "/java-test/extension",
    java_debug_adapter = mason .. "/java-debug-adapter/extension",
}

require("java").setup({
    jdtls = {
        path = paths.jdtls,
        auto_install = false,
    },
    lombok = {
        path = paths.lombok,
        auto_install = false,
    },
    java_test = {
        enable = vim.uv.fs_stat(optional.java_test) ~= nil,
        path = optional.java_test
    },
    java_debug_adapter = {
        enable = vim.uv.fs_stat(optional.java_debug_adapter) ~= nil,
        path = optional.java_debug_adapter,
    },
    spring_boot_tools = {
        enable = vim.uv.fs_stat(optional.spring_boot_tools) ~= nil,
        path = optional.spring_boot_tools,
        auto_install = false,
    },
    jdk = {
        path = paths.jdk,
        auto_install = false,
    },
})
