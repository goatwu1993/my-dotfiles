call plug#begin('~/.vim/plugged')
" Plug 'haya14busa/vim-easymotion'
Plug 'Mofiqul/dracula.nvim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'fatih/vim-hclfmt'
Plug 'glench/vim-jinja2-syntax'
Plug 'hashivim/vim-terraform'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'jelera/vim-javascript-syntax'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'preservim/nerdcommenter'
Plug 'psf/black'
Plug 'tpope/vim-surround'
Plug 'williamboman/nvim-lsp-installer'
Plug 'kyazdani42/nvim-web-devicons'
call plug#end()
