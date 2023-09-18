local jdtls_dir = vim.fn.stdpath('data') .. '/mason/share/jdtls'
local config_dir = jdtls_dir .. '/config'
local plugin_dir = jdtls_dir .. '/plugins'
local path_to_jar = plugin_dir .. "org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar"
local path_to_lombok = jdtls_dir .. '/lomboks.jar'

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('cache') .. '/jdtls/workspace/' .. project_name
local config = {
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '-javaagent:' .. path_to_lombok,
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', path_to_jar,

        '-configuration', config_dir,
        '-data', workspace_dir,
    },
    root_dir = {
        {
            'build.xml',           -- Ant
            'pom.xml',             -- Maven
            'settings.gradle',     -- Gradle
            'settings.gradle.kts', -- Gradle
        },
        { 'build.gradle', 'build.gradle.kts' },
    } or vim.fn.getcwd(),
    init_options = {
        jvm_args = {},
        workspace = workspace_dir,
    }
}

-- return require("jdtls").start_or_attach(config)
