-- vim.opt.backspace   =indent,eol,start
-- vim.opt.clipboard+=unnamedplus
-- vim.opt.cursorline              -- Find the current line quickly.
-- vim.opt.display     =lastline   -- Show as much as possible of the last line.
-- vim.opt.signcolumn= true          -- Warning/Error sign column
-- vim.opt.syntax on
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.eol = false
vim.opt.expandtab = true -- Use spaces instead of tabs.
vim.opt.fixendofline = false
vim.opt.guicursor = 'i:blinkwait700-blinkoff400-blinkon250-block' -- This patch insert mode cursor back to blinking block
vim.opt.hidden = true -- Switch between buffers without having to save first.
vim.opt.hlsearch = false
vim.opt.ignorecase = true -- ignore case when search
vim.opt.laststatus = 2 -- Always show statusline.
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.report = 0 -- Always report changed lines.
vim.opt.shiftround = true -- indents to next multiple of 'shiftwidth'.
vim.opt.showcmd = true -- Show already typed keys when more are expected.
vim.opt.showmode = true -- Show current mode in command-line.
vim.opt.smartcase = true -- ignore case when search
vim.opt.smarttab = true
vim.opt.splitbelow = true -- Open new windows below the current window.
vim.opt.splitright = true -- Open new windows right of the current window.
vim.opt.sts = 4 -- softtab stop
vim.opt.sw = 4 -- shiftwidth
vim.opt.swapfile = false
vim.opt.synmaxcol = 1000 -- Only highlight the first 200 columns.
vim.opt.ts = 4
vim.opt.ttyfast = true -- Faster redrawing.
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undo'
vim.opt.undofile = true
vim.opt.updatecount = 100
vim.opt.wrapscan = true -- Searches wrap around end-of-file.
--vim.o.clipboard = vim.o.clipboard .. "unnamedplus"
vim.api.nvim_set_keymap('n', 'u', '<nop>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>u', ':undo<CR>', { noremap = true, silent = true }) -- Map leader u to undo
-- this is to delete without yanking in normal mode
vim.api.nvim_set_keymap('n', 'dd', '"_dd', { noremap = true })

vim.cmd([[
  augroup jump_back
    autocmd!
    autocmd BufReadPost *
          \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
          \ |   execute "normal! g`\""
          \ | endif
  augroup END
]])

--vim.filetype.add({
--  pattern = {
--    -- Any YAML inside Helm templates/ is Helm template
--    [".*/templates/.*%.yaml"] = "helm",
--    [".*/templates/.*%.yml"] = "helm",
--    ---- Values files
--    --["values%.yaml"] = "helm",
--    --["values%.yml"] = "helm",
--  },
--})
