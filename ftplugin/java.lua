---@diagnostic disable: param-type-mismatch
local jdtls_path = vim.fn.stdpath("data") .. "/mason/share/jdtls"
local jar_dir = jdtls_path .. "/plugins/org.eclipse.equinox.launcher.jar"
local config_dir = jdtls_path .. "/config"
local lombok = jdtls_path .. '/lombok.jar'

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local workspace_dir = vim.fn.getenv("HOME") .. '/workspace/java/' .. project_name

local config = {
    cmd = {
        '/usr/bin/java',

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',

        '-javaagent:' .. lombok,

        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        '-jar', jar_dir,

        '-configuration', config_dir,

        '-data', workspace_dir,
    },

    root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' }),

    settings = {
        java = {
        }
    },

    init_options = {
        bundles = {}
    },
}

local jdtls = require('jdtls')

local on_attach = function(client, bufnr)
    vim.keymap.set('n', '<leader>op', function() jdtls.organize_imports() end, { desc = "jdtls extract_variable" })

    vim.keymap.set('n', '<leader>crv', function() jdtls.extract_variable() end, { desc = "jdtls extract_variable" })
    vim.keymap.set('v', '<leader>crv', function() jdtls.extract_variable(true) end,
        { desc = "jdtls extract_variable" })

    vim.keymap.set('n', '<leader>crv', function()
        jdtls.extract_constant()
    end, { desc = "jdtls extract_variable" })

    vim.keymap.set('v', '<leader>crv', function()
        jdtls.extract_constant(true)
    end, { desc = "jdtls extract_variable" })
end

config.on_attach = on_attach
require('jdtls').start_or_attach(config)
