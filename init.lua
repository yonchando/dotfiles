require("chando")

vim.pack.add({
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' }, -- optional

    -- Syntax highlight
    'https://github.com/nvim-treesitter/nvim-treesitter',

    -- Theme
    'https://github.com/folke/tokyonight.nvim',

    -- Explore sidebar
    { src = 'https://github.com/nvim-tree/nvim-tree.lua' },

    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/christoomey/vim-tmux-navigator",
    "https://github.com/stevearc/conform.nvim.git",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/rcarriga/nvim-notify",
    "https://github.com/folke/noice.nvim",
    {
        src = "https://github.com/kylechui/nvim-surround",
        version = vim.version.range("4.x"), -- Use for stability; omit to use `main` branch for the latest features
    },
    { src = 'https://github.com/akinsho/bufferline.nvim', version = vim.version.range("4.x") },

    -- LSP
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/neovim/nvim-lspconfig',

    -- autocompletion
    'https://github.com/rafamadriz/friendly-snippets',
    'https://github.com/saghen/blink.lib',
    'https://github.com/saghen/blink.cmp'
}, {
    confirm = false
})


require("nvim-autopairs").setup {}

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run the first available formatter
        javascript = { "prettierd", "prettier", stop_after_first = true },
    },
    format_on_save = {
        timeout_ms = 50000,
        lsp_format = "fallback"
    }
})
