require("chando")

vim.pack.add({
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-lua/plenary.nvim',

    -- window popup
    'https://github.com/MunifTanjim/nui.nvim',

    -- popup message
    'https://github.com/folke/noice.nvim',
    'https://github.com/rcarriga/nvim-notify',

    -- themes
    'https://github.com/folke/tokyonight.nvim',

    -- ui
    'https://github.com/lukas-reineke/indent-blankline.nvim',
    'https://github.com/nvim-lualine/lualine.nvim',
    { src = 'https://github.com/akinsho/bufferline.nvim', version = vim.version.range("4.x") },

    -- nav
    'https://github.com/nvim-tree/nvim-tree.lua',
    'https://github.com/christoomey/vim-tmux-navigator',

    -- git
    'https://github.com/lewis6991/gitsigns.nvim',
    'https://github.com/tpope/vim-fugitive',

    -- editor
    'https://github.com/brenton-leighton/multiple-cursors.nvim',
    'https://github.com/windwp/nvim-autopairs',
    { src = 'https://github.com/kylechui/nvim-surround',  version = vim.version.range("4.x") },

    -- formatting
    'https://github.com/stevearc/conform.nvim.git',

    -- Treesitter
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
    'https://github.com/nvim-treesitter/nvim-treesitter',

    -- Teelescope
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
    'https://github.com/nvim-telescope/telescope-ui-select.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',

    -- LSP
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/mason-org/mason-lspconfig.nvim',
    'https://github.com/folke/lazydev.nvim',

    -- autocompletion
    'https://github.com/rafamadriz/friendly-snippets',
    'https://github.com/L3MON4D3/LuaSnip',
    'https://github.com/saghen/blink.lib',
    'https://github.com/saghen/blink.cmp',
}, {
    confirm = false
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = 'lua',
    once = true,
    callback = function()
        vim.cmd("packadd lazydev.nvim")

        -- lazydev
        require("lazydev").setup({
            library = {
                {
                    path = "${3rd}/luv/library",
                    word = { "vim%.uv" }
                }
            }
        })
    end
})
