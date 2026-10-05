-- Bootstrap lazy.nvim
-- Configure lazy.nvim
vim.pack.add({
    -- Comment utilities
    'https://github.com/preservim/nerdcommenter',

    -- GitHub Copilot
    'https://github.com/github/copilot.vim',

    -- Snippets
    'https://github.com/hrsh7th/vim-vsnip',

    -- Flash motion
    {
        src = 'https://github.com/folke/flash.nvim',
        event = 'VeryLazy',
        opts = {},
    },

    -- Telescope fuzzy finder
    {
        src = 'https://github.com/nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },

    -- Helm support
    'https://github.com/towolf/vim-helm',

    -- Stylua formatter
    'https://github.com/ckipp01/stylua-nvim',

    -- Rose Pine colorscheme
    {
        src = 'https://github.com/rose-pine/neovim',
        name = 'rose-pine',
        priority = 1000,
    },


    -- Git integration
    'https://github.com/tpope/vim-fugitive',

    -- LSP Zero and dependencies
    {
        src = 'https://github.com/VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
    },
    'https://github.com/hrsh7th/nvim-cmp',
    'https://github.com/L3MON4D3/LuaSnip',
    'https://github.com/rafamadriz/friendly-snippets',

    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/williamboman/mason.nvim',
    'https://github.com/williamboman/mason-lspconfig.nvim',

    -- Autocompletion

    'https://github.com/hrsh7th/cmp-buffer',
    'https://github.com/hrsh7th/cmp-path',
    'https://github.com/saadparwaiz1/cmp_luasnip',
    'https://github.com/hrsh7th/cmp-nvim-lsp',
    'https://github.com/hrsh7th/cmp-nvim-lua',


    -- Zen mode
    {
        src = 'https://github.com/folke/zen-mode.nvim',
        opts = {},
    },

    ---- TypeScript utilities
    --'https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils',

    -- Terraform support
    'https://github.com/hashivim/vim-terraform',

    -- Easy motion
    'https://github.com/easymotion/vim-easymotion',
})
