return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    dependencies = {
        'nvim-treesitter/playground',
    },
    config = function()
        local status_ok, nvimtreesitter = pcall(require, "nvim-treesitter.configs")
        if not status_ok then
            return
        end

        nvimtreesitter.setup {
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "css",
                "html",
                "javascript",
                "typescript",
                "php",
                "xml",
                "vue",
                "yaml",
                "json"
            },

            matchup = {
                enable = true,
            },

            sync_install = false,

            auto_install = true,

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

            indent = {
                enable = true,
                disable = {
                    'html',
                }
            },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<c-space>',
                    node_incremental = '<c-space>',
                    node_decremental = '<M-space>',
                },
            },

            autotag = {
                enable = true
            },

            playground = {
                enable = true,
                updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
                persist_queries = false, -- Whether the query persists across vim sessions
                keybindings = {
                    toggle_query_editor = 'o',
                    toggle_hl_groups = 'i',
                    toggle_injected_languages = 't',
                    toggle_anonymous_nodes = 'a',
                    toggle_language_display = 'I',
                    focus_language = 'f',
                    unfocus_language = 'F',
                    update = 'R',
                    goto_node = '<cr>',
                    show_help = '?',
                },
            }
        }
    end
}
