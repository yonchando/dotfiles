require("chando")

vim.pack.add({
    -- Syntax highlight
    'https://github.com/nvim-treesitter/nvim-treesitter',

    -- Theme
    'https://github.com/folke/tokyonight.nvim',

    -- Explore sidebar
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' }, -- optional
    { src = 'https://github.com/nvim-tree/nvim-tree.lua' },

    -- Telescope
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },

    -- Tmux/panel navigation
    { src = "https://github.com/christoomey/vim-tmux-navigator" },

    "https://github.com/lukas-reineke/indent-blankline.nvim",

    "https://github.com/nvim-lualine/lualine.nvim",

    {
        src = "https://github.com/kylechui/nvim-surround",
        version = vim.version.range("4.x"), -- Use for stability; omit to use `main` branch for the latest features
    },

    "https://github.com/windwp/nvim-autopairs",

    "https://github.com/lewis6991/gitsigns.nvim",

    'https://github.com/akinsho/bufferline.nvim' 
}, {
    confirm = false
})

require("nvim-autopairs").setup {}
--
require('gitsigns').setup({
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

    end
})
