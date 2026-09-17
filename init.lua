require("chando")

vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    'https://github.com/nvim-tree/nvim-web-devicons',
    "https://github.com/nvim-tree/nvim-tree.lua",
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/rcarriga/nvim-notify",
    'https://github.com/folke/tokyonight.nvim',
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/christoomey/vim-tmux-navigator",
    "https://github.com/stevearc/conform.nvim.git",
    "https://github.com/folke/noice.nvim",
    {
        src = "https://github.com/kylechui/nvim-surround",
        version = vim.version.range("4.x"), -- Use for stability; omit to use `main` branch for the latest features
    },
    { src = 'https://github.com/akinsho/bufferline.nvim', version = vim.version.range("4.x") },

    -- Teelescope
    "https://github.com/nvim-telescope/telescope-ui-select.nvim",
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",

    -- LSP
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/mason-org/mason-lspconfig.nvim',

    -- autocompletion
    'https://github.com/rafamadriz/friendly-snippets',
    'https://github.com/L3MON4D3/LuaSnip',
    'https://github.com/saghen/blink.lib',
    'https://github.com/saghen/blink.cmp'
}, {
    confirm = false
})

require("nvim-autopairs").setup {}
