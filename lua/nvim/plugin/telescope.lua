local status_ok, telescope = pcall(require,"telescope")
if not status_ok then
    return
end

telescope.setup{
    defaults = {
        layout_config = {
            vertical = { width = 1.5 }
        },
        mappings = {
            i = {
                ["<C-h>"] = "which_key"
            }
        },
        theme = "dropdown"
    },
    pickers = {
        find_files = {
            theme = "dropdown",
            previewer = false,
        },
        git_files = {
            theme = "dropdown",
            previewer = false,
        },
        oldfiles = {
            theme = "dropdown",
            previewer = false,
        }
    },
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {

            }
        }
    }
}

telescope.load_extension('fzf')
telescope.load_extension("ui-select")
