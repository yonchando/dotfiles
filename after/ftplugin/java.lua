local mason_registry = require("mason-registry")

if not mason_registry.has_package('jdtls') then
    return
end

local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local lombok = jdtls_path .. "/lombok.jar"
local workspace = os.getenv("HOME") .. "/.cache/jdtls/workspace/" .. project_name
local configuration = jdtls_path .. "/config_linux"
local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

local config = {
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-javaagent:' .. lombok,
        '-jar', launcher,
        '-configuration', configuration,
        '-data', workspace
    },
    root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),
}

require("jdtls").start_or_attach(config)
