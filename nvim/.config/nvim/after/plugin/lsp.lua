local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
-- float = true to show the diagnostic in a floating window after jumping to the next/previous diagnostic
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
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
local global_on_attach = function(_client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

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

    -- Auto-format on save (only if client supports formatting)
    if _client.server_capabilities.documentFormattingProvider then
        local augroup = vim.api.nvim_create_augroup('LspFormatOnSave_' .. bufnr, { clear = true })
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end
end

vim.opt.completeopt = {
    'menu',
    'menuone',
    'noselect',
    'popup',
}

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my-lsp-completion', {
        clear = true,
    }),

    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, {
                autotrigger = true,
            })
        end
    end,
})

vim.keymap.set('i', '<C-Space>', function()
    vim.lsp.completion.get()
end, {
    desc = 'Trigger LSP completion',
})

vim.keymap.set('i', '<CR>', function()
    if vim.fn.pumvisible() == 1 then
        return '<C-y>'
    end

    return '<CR>'
end, {
    expr = true,
})

vim.lsp.enable('pyrefly')
vim.lsp.config('pyrefly', {
    on_attach = global_on_attach,
})

vim.lsp.enable('terraformls')
vim.lsp.config('terraformls', {
    cmnd = { 'terraform-ls', 'serve' },
    on_attach = global_on_attach,
    filetypes = { 'terraform', 'tf' },
})


vim.lsp.enable('lua_ls')
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
    on_attach = global_on_attach,
})


vim.lsp.enable('tsserver')
vim.lsp.config('tsserver', {
    -- Needed for inlayHints. Merge this table with your settings or copy
    -- it from the source if you want to add your own init_options.
    --init_options = require('nvim-lsp-ts-utils').init_options,
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

--local ruff_format_on_save = function()
--    vim.lsp.buf.format({ async = false })
--    vim.lsp.buf.code_action({
--        context = {
--            diagnostics = vim.diagnostic.get(),
--            only = {
--                'source.fixAll',
--            },
--        },
--        apply = true,
--    })
--end

local ruff_format_on_save = function()
    vim.lsp.buf.format({
        async = false,
        name = 'ruff',
    })

    vim.lsp.buf.code_action({
        context = {
            only = {
                'source.fixAll.ruff',
            },
        },
        apply = true,
    })
end

local function should_enable_ruff()
    local cwd = vim.fn.getcwd()
    -- Disable for this specific repo
    --if cwd:match("securitydashboard/djangoapp") then
    --    return false
    --end
    return true
end

if should_enable_ruff() then
    vim.lsp.enable('ruff')
end

vim.lsp.config('ruff', {
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
    on_attach = global_on_attach,
})

vim.lsp.enable('taplo')
vim.lsp.config('taplo', {
    on_attach = global_on_attach,
    filetypes = { 'toml' },
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
