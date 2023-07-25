--autocmd FileType vim,lua setlocal ts=4 sts=4 sw=4 expandtab
--autocmd FileType json,md,typescript,js setlocal ts=2 sts=2 sw=2 expandtab
--"autocmd BufWritePre *.py execute ':Black'
--autocmd BufWritePre *.tf execute ':TerraformFmt'
--autocmd BufWritePre *.hcl execute ':HclFmt'
--autocmd BufWritePre *.ts,*.js execute ':EslintFixAll'
--autocmd BufReadPost *
--      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
--      \ |   exe "normal! g`\""
--      \ | endif

-- black
vim.cmd [[
autocmd BufWritePre *.py Black
autocmd FileType json,md,typescript,js setlocal ts=2 sts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.tf,*.tfvars,*.hcl set filetype=terraform
autocmd BufWritePre *.tf,*.tfvars,*.hcl TerraformFmt
autocmd BufWritePre *.go GoFmt
autocmd FileType go setlocal ts=4 sts=4 sw=4 expandtab
]]

--vim.cmd [[
--autocmd BufReadPost *
--    \ echo 'Filetype: ' .. &filetype .. ' | '
--    \ .. 'tabstop=' .. &tabstop .. ' | '
--    \ .. 'shiftwidth=' .. &shiftwidth .. ' | '
--    \ .. 'expandtab: ' .. (&expandtab and 'yes' or 'no')
--]]

---- print something
--print("hello world")
