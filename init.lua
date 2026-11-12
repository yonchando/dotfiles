vim.api.nvim_create_autocmd("PackChanged", {
    pattern = "telescope-fzf-native.nvim",
    callback = function(e)
        vim.schedule(function()
            vim.cmd("! cd " .. e.data.path .. " && make")
        end)
    end
})

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
    { src = 'https://github.com/kylechui/nvim-surround',  version = vim.version.range("4.x") },
    'https://github.com/brenton-leighton/multiple-cursors.nvim',
    'https://github.com/windwp/nvim-autopairs',
    "https://github.com/mbbill/undotree",
    "https://github.com/tpope/vim-dadbod",

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
    'https://github.com/onsails/lspkind.nvim',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/mason-org/mason-lspconfig.nvim',
    'https://github.com/folke/lazydev.nvim',

    {
        src = 'https://github.com/JavaHello/spring-boot.nvim',
        version = '218c0c26c14d99feca778e4d13f5ec3e8b1b60f0',
    },
    'https://github.com/mfussenegger/nvim-dap',

    'https://github.com/nvim-java/nvim-java',

    -- autocompletion
    'https://github.com/rafamadriz/friendly-snippets',
    'https://github.com/L3MON4D3/LuaSnip',
    'https://github.com/saghen/blink.lib',
    'https://github.com/saghen/blink.cmp',
}, {
    confirm = false
})

require("chando")
