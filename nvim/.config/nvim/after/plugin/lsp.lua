local cmp = require('cmp')

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
vim.api.nvim_set_keymap(
    'n',
    '<Leader>rn',
    '<Cmd>lua vim.lsp.buf.rename()<CR>',
    { noremap = true, silent = true }
)

local function is_biome_repo()
    -- root
    local lsp_util = require('lspconfig').util
    -- Define the root directory using the presence of a .git directory as an indicator
    local root_dir = lsp_util.root_pattern('.git')(vim.fn.getcwd())
    -- fmt.print root
    print(root_dir)
    if root_dir == nil then
        return false
    end
    local biome_config_path = root_dir .. '/biome.json'
    local biome_config_exists = vim.fn.filereadable(biome_config_path) == 1
    if biome_config_exists then
        return true, biome_config_path
    end
    -- pwd.biome check
    local pwd_biome_config_path = vim.fn.getcwd() .. '/biome.json'
    local pwd_biome_config_exists = vim.fn.filereadable(pwd_biome_config_path) == 1
    if pwd_biome_config_exists then
        return true, pwd_biome_config_path
    end
    return false, nil
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local global_on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- peek definition
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gp', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        '<C-k>',
        '<cmd>lua vim.lsp.buf.signature_help()<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        '<space>wa',
        '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        '<space>wr',
        '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        '<space>wl',
        '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        '<space>D',
        '<cmd>lua vim.lsp.buf.type_definition()<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        '<space>ca',
        '<cmd>lua vim.lsp.buf.code_action()<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        '<space>f',
        '<cmd>lua vim.lsp.buf.formatting()<CR>',
        opts
    )
end

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        --["<Tab>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }),
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    }),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' },
    }, {
        { name = 'cmdline' },
    }),
})

-- Setup lspconfig.
local capabilities =
    require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.

vim.lsp.enable('pyright')
vim.lsp.config('pyright', {
    capabilities = capabilities,
    on_attach = global_on_attach,
})

vim.lsp.enable('terraformls')
vim.lsp.config('terraformls', {
    cmnd = { 'terraform-ls', 'serve' },
    on_attach = global_on_attach,
    filetypes = { 'terraform', 'tf' }, 
})

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false, -- THIS IS THE IMPORTANT LINE TO ADD
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
            formatting = {
                --disable the formatter, use stylua instead
                enable = true,
            },
        },
    },
    on_attach = global_on_attach;
})


vim.lsp.enable('tsserver')
vim.lsp.config('tsserver', {
    capabilities = capabilities,
    -- Needed for inlayHints. Merge this table with your settings or copy
    -- it from the source if you want to add your own init_options.
    init_options = require('nvim-lsp-ts-utils').init_options,
    --
    filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript', 'javascriptreact', 'javascript.jsx' },
    on_attach = function(client, bufnr)
        global_on_attach(client, bufnr)

        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
        local ts_utils = require('nvim-lsp-ts-utils')

        -- defaults
        ts_utils.setup({
            auto_inlay_hints = false,
            filter_out_diagnostics_by_severity = { 'hint', 'info' },
            --update_imports_on_move = true,
            --require_confirmation_on_move = false
        })

        -- required to fix code action ranges and filter diagnostics
        ts_utils.setup_client(client)

        -- no default maps, so you may want to define some here
        local locaVarOpts = { silent = true }
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', ':TSLspOrganize<CR>', locaVarOpts)
        -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gS', ':TSLspImportAll<CR>', locaVarOpts)
    end,
    cmd = { 'typescript-language-server', '--stdio' },
})

local ruff_format_on_save = function()
    vim.lsp.buf.format({ async = false })
    vim.lsp.buf.code_action({
        context = {
            diagnostics = vim.diagnostic.get(),
            only = {
                'source.fixAll',
            },
        },
        apply = true,
    })
end

vim.lsp.enable('ruff')
vim.lsp.config('ruff', {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        global_on_attach(client, bufnr)
        --vim.api.nvim_create_autocmd({
        --    buffer = bufnr,
        --    callback = function()
        --        vim.lsp.buf.code_action({
        --        context = { only = { "source.fixAll" } },
        --        apply = true,
        --        })
        --        vim.lsp.buf.formatting_sync(nil, 1000)
        --        vim.wait(100)
        --    end,
        --}, "BufWritePre")
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format({ async = true })
        end, bufopts)
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = vim.api.nvim_create_augroup('ruff_format_on_save', { clear = true }),
            callback = ruff_format_on_save,
        })
        -- set autocmd BufWritePre
    end,
    settings = {
        codeActionOnSave = {
            enable = true,
            mode = 'all',
        },
    },
})


-- if the file is a go file, set up gopls
vim.lsp.enable('gopls')
vim.lsp.config('gopls', {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        global_on_attach(client, bufnr)
        vim.api.nvim_command('augroup yaml_fmt')
        vim.api.nvim_command('autocmd BufWritePre <buffer> lua vim.lsp.buf.format()')
        vim.api.nvim_command('augroup END')
    end,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
    filetypes = { 'go', 'gomod' },
})

--local function setup_rust_fmt()
--    local ft = vim.api.nvim_buf_get_option(0, 'filetype')
--    if ft == 'rust' then
--        vim.api.nvim_command('augroup rust_fmt')
--        vim.api.nvim_command('autocmd!')
--        vim.api.nvim_command('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
--        vim.api.nvim_command('augroup END')
--    end
--end

vim.lsp.enable('rust_analyzer')
vim.lsp.config('rust_analyzer', {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        global_on_attach(client, bufnr)
        vim.api.nvim_command('augroup rust_fmt')
        vim.api.nvim_command('autocmd!')
        vim.api.nvim_command('autocmd BufWritePre <buffer> lua vim.lsp.buf.format({async = false})')
        vim.api.nvim_command('augroup END')
    end,
})

vim.lsp.enable('jsonls')
vim.lsp.config('jsonls', {
    capabilities = capabilities,
    on_attach = global_on_attach,
})

local biome_format_on_save = function()
    vim.lsp.buf.format({ async = false })
    vim.lsp.buf.code_action({
        context = {
            diagnostics = vim.diagnostic.get(0),
            only = {
                'source.fixAll',
            },
        },
        apply = true,
    })
end

-- biome
vim.lsp.enable('biome')
if is_biome_repo() then
    vim.lsp.config('biome', {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            global_on_attach(client, bufnr)
            --vim.api.nvim_buf_set_keymap(
            --    bufnr,
            --    'n',
            --    '<Leader>rn',
            --    '<Cmd>lua vim.lsp.buf.rename()<CR>',
            --    { noremap = true, silent = true }
            --)
            -- auto format
            -- use biome fix all
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('biome_format_on_save', { clear = true }),
                callback = biome_format_on_save,
            })
        end,
    })
else
    vim.lsp.config('eslint', {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            global_on_attach(client, bufnr)
            vim.cmd([[autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll]])
        end,
        settings = {
            codeActionOnSave = {
                enable = true,
                mode = 'all',
            },
        },
    })
end

vim.lsp.enable('yamlls')
vim.lsp.config('yamlls', {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        global_on_attach(client, bufnr)
        vim.api.nvim_command('augroup yaml_fmt')
        vim.api.nvim_command('autocmd BufWritePre <buffer> lua vim.lsp.buf.format()')
        vim.api.nvim_command('augroup END')
    end,
    settings = {
        yaml = {
            format = {
                enable = true,
            },
            validate = true,
            schemas = {
                ['.github/dependabot.yml'] = 'https://json.schemastore.org/dependabot-2.0.json',
                ['.github/dependabot.yaml'] = 'https://json.schemastore.org/dependabot-2.0.json',
                ['infrastructure/**/*.yml'] = 'kubernetes',
                ['infrastructure/**/*.yaml'] = 'kubernetes',
                ['**/*.k8s.yaml'] = 'kubernetes',
                ['**/*.k8s.yml'] = 'kubernetes',
            },
        },
        redhat = {
            telemetry = {
                enabled = false,
            },
        },
    },
})

vim.lsp.config('golangci_lint_ls', {
    capabilities = capabilities,
    cmd_env = { GOFUMPT_SPLIT_LONG_LINES = 'on' },
    on_attach = function(client, bufnr)
        global_on_attach(client, bufnr)
        vim.api.nvim_command('augroup go_fmt')
        vim.api.nvim_command('autocmd BufWritePre <buffer> lua vim.lsp.buf.format()')
        vim.api.nvim_command('augroup END')
    end,
})

--require("treesitter-context").setup({
--    enable = true, -- enable this plugin (can be enabled/disabled later via commands)
--    max_lines = 0, -- how many lines the window should span. values <= 0 mean no limit.
--    min_window_height = 0, -- minimum editor window height to enable context. values <= 0 mean no limit.
--    line_numbers = true,
--    multiline_threshold = 20, -- maximum number of lines to show for a single context
--    trim_scope = "outer", -- which context lines to discard if `max_lines` is exceeded. choices: 'inner', 'outer'
--    mode = "cursor", -- line used to calculate context. choices: 'cursor', 'topline'
--    -- separator between context and content. should be a single character string, like '-'.
--    -- when separator is set, the context will only show up when there are at least 2 lines above cursorline.
--    separator = nil,
--    zindex = 20, -- the z-index of the context window
--    on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
--})
