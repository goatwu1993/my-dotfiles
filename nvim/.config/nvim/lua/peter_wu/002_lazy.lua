-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
require('lazy').setup({
    -- Comment utilities
    'preservim/nerdcommenter',

    -- GitHub Copilot
    'github/copilot.vim',

    -- Snippets
    'hrsh7th/vim-vsnip',

    -- Flash motion
    {
        'folke/flash.nvim',
        event = 'VeryLazy',
        opts = {},
    },

    -- Telescope fuzzy finder
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },

    -- Helm support
    'towolf/vim-helm',

    -- Stylua formatter
    'ckipp01/stylua-nvim',

    -- Rose Pine colorscheme
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        priority = 1000,
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
            if not status_ok then
                return
            end
            configs.setup({
                ensure_installed = {
                    'lua',
                    'vim',
                    'vimdoc',
                    'python',
                    'javascript',
                    'typescript',
                    'rust',
                    'go',
                    'yaml',
                    'json',
                    'terraform',
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    },

    -- Git integration
    'tpope/vim-fugitive',

    -- LSP Zero and dependencies
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Autocompletion
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',

            -- Snippets
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
        },
    },

    -- Zen mode
    {
        'folke/zen-mode.nvim',
        opts = {},
    },

    -- TypeScript utilities
    'jose-elias-alvarez/nvim-lsp-ts-utils',

    -- Terraform support
    'hashivim/vim-terraform',

    -- Easy motion
    'easymotion/vim-easymotion',
}, {
    -- Lazy.nvim configuration options
    ui = {
        border = 'rounded',
    },
    performance = {
        rtp = {
            disabled_plugins = {
                'gzip',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },
})
