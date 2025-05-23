vim.cmd.packadd("packer.nvim")

return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")
    use("preservim/nerdcommenter")
    use("github/copilot.vim")
    use("hrsh7th/vim-vsnip")
    use("folke/flash.nvim")
    use({
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        requires = { { "nvim-lua/plenary.nvim" } },
    })
    use({ "ckipp01/stylua-nvim" })

    use({
        "rose-pine/neovim",
        as = "rose-pine",
        config = function()
            vim.cmd("colorscheme rose-pine")
        end,
    })

    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    })
    -- use("nvim-treesitter/playground")
    use("tpope/vim-fugitive")
    --use("nvim-treesitter/nvim-treesitter-context")
    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "v1.x",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        },
    })
    use({
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    })
    --use {
    --'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
    --requires = { {'nvim-lua/plenary.nvim'} }
    -- }

    use("jose-elias-alvarez/nvim-lsp-ts-utils")
    use("hashivim/vim-terraform")
    use("easymotion/vim-easymotion")
    --use {
    --  'juliosueiras/vim-terraform-completion',
    --   ft = { 'terraform', 'hcl' },
    --   opt = true,
    --   use {
    --      'juliosueiras/vim-terraform-completion',
    --      ft = { 'terraform', 'hcl' },
    --      opt = true,
    --  } }
end)
