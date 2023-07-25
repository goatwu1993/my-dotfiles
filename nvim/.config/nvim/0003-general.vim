"xnoremap p pgvy             " paste not copy
set autoindent              " Indent according to previous line.
set backspace   =indent,eol,start  " Make backspace work as you would expect.
set cindent
set clipboard+=unnamedplus
set cursorline              " Find the current line quickly.
set display     =lastline   " Show as much as possible of the last line.
set expandtab               " Use spaces instead of tabs.
set guicursor=i:blinkwait700-blinkoff400-blinkon250-block " This patch insert mode cursor back to blinking block
set hidden                  " Switch between buffers without having to save first.
"set hlsearch                " Keep matches highlighted.
set ignorecase              " ignore case when search
set incsearch               " Highlight while searching with / or ?.
set laststatus  =2          " Always show statusline.
set lazyredraw              " Only redraw when necessary.
set noeol
set nofixendofline
set noswapfile
set number
set report      =0          " Always report changed lines.
set rnu                     " set relative line number
set ruler
set shiftround              " indents to next multiple of 'shiftwidth'.
set showcmd                 " Show already typed keys when more are expected.
set showmode                " Show current mode in command-line.
set signcolumn=yes          " Warning/Error sign column
set smartcase               " ignore case when search
set smarttab
set splitbelow              " Open new windows below the current window.
set splitright              " Open new windows right of the current window.
set sts=4                   " softtab stop
set sw=4             	    " shiftwidth
set synmaxcol   =200        " Only highlight the first 200 columns.
set ts=4
set ttyfast                 " Faster redrawing.
set undodir     =$HOME/.vim/files/undo/
set undofile
set updatecount =100
set wrapscan                " Searches wrap around end-of-file.
set nohlsearch
syntax on


if (has('termguicolors'))
    set termguicolors
    colorscheme dracula
endif
