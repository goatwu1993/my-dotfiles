-- Setup nvim-cmp.
-- bootstrap lazy.nvim, LazyVim and your plugins
-- -- Set the font for Neovim
require 'peter_wu'
--vim.opt.shell = '/bin/bash'
vim.cmd 'set guifont="Hack Nerd Font:h12"'

-- Enable Nerd Fonts in the terminal
vim.o.termguicolors = true
-- not used anymore since everything looks fine on 0.9 stable and 0.10 nightly
-- keep it here for future references
-- TODO: remove it after a while
--vim.o.t_8f = [[<Esc>[38;2;%lu;%lu;%lum]]
--vim.o.t_8b = [[<Esc>[48;2;%lu;%lu;%lum]]
