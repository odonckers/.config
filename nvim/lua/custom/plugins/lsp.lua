return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        -- Completion sources
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'f3fora/cmp-spell',
        'hrsh7th/nvim-cmp',

        -- Snippet collections
        'rafamadriz/friendly-snippets',

        -- Language support
        { 'folke/lazydev.nvim', ft = 'lua', config = true },
        { 'GustavEikaas/easy-dotnet.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
        { 'antosha417/nvim-lsp-file-operations', dependencies = { 'nvim-lua/plenary.nvim' } },

        -- Formatting
        'stevearc/conform.nvim',
    },
    config = function()
        -- Disable builtin completion keys
        vim.keymap.set({ 'i', 's' }, '<C-p>', '<nop>')
        vim.keymap.set({ 'i', 's' }, '<C-n>', '<nop>')

        -- Setup completion
        local cmp = require('cmp')
        cmp.setup({
            snippet = {
                expand = function(args) vim.snippet.expand(args.body) end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'easy-dotnet' },
                { name = 'path' },
                { name = 'buffer' },
                { name = 'spell' },
            }),
        })

        -- Use buffer source for `/` and `?` (if you enabled `view.entries = 'native'`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' },
            },
        })

        -- Use cmdline & path source for ':' (if you enabled `view.entries = 'native'`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' },
            }, {
                { name = 'cmdline' },
            }),
        })

        -- Setup LSP file operations
        require('lsp-file-operations').setup()

        -- Setup language servers
        local capabilities = vim.tbl_deep_extend(
            'force',
            vim.lsp.protocol.make_client_capabilities(),
            require('cmp_nvim_lsp').default_capabilities()
        )

        -- LuaLS/lua-language-server
        vim.lsp.config('lua_ls', {
            capabilities = capabilities,
            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if
                        path ~= vim.fn.stdpath('config')
                        ---@diagnostic disable-next-line: undefined-field
                        and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                    then
                        return
                    end
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                    runtime = {
                        version = 'LuaJIT',
                        path = { 'lua/?.lua', 'lua/?/init.lua' },
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = { vim.env.VIMRUNTIME },
                    },
                })
            end,
            settings = {
                Lua = {},
            },
        })
        vim.lsp.enable('lua_ls')

        -- HTML (npm:vscode-langservers-extracted)
        vim.lsp.config('html', { capabilities = capabilities })
        vim.lsp.enable('html')

        -- CSS (npm:vscode-langservers-extracted)
        vim.lsp.config('cssls', { capabilities = capabilities })
        vim.lsp.enable('cssls')

        -- JSON (npm:vscode-langservers-extracted)
        vim.lsp.config('jsonls', { capabilities = capabilities })
        vim.lsp.enable('jsonls')

        -- ESLint (npm:vscode-langservers-extracted)
        vim.lsp.config('eslint', {
            capabilities = capabilities,
            settings = {
                useESLintClass = false,
                experimental = { useFlatConfig = true },
            },
        })
        vim.lsp.enable('eslint')

        -- TypeScript / JavaScript (npm:@vtsls/language-server)
        vim.lsp.config('vtsls', { capabilities = capabilities })
        vim.lsp.enable('vtsls')

        -- Angular (npm:@angular/language-server)
        vim.lsp.config('angularls', { capabilities = capabilities })
        vim.lsp.enable('angularls')

        -- Setup dotnet
        vim.lsp.config('easy_dotnet', { capabilities = capabilities })
        local easy_dotnet = require('easy-dotnet')
        easy_dotnet.setup()
        cmp.register_source('easy-dotnet', easy_dotnet.package_completion_source)

        -- GitHub Copilot (npm:@github/copilot-language-server)
        vim.lsp.config('copilot', { capabilities = capabilities })
        vim.lsp.enable('copilot')

        -- Swift (macOS:SourceKit)
        vim.lsp.config('sourcekit', { capabilities = capabilities })
        vim.lsp.enable('sourcekit')

        -- Formatting
        require('conform').setup({
            formatters_by_ft = {
                lua = { 'stylua' },
                bash = { 'shfmt' },
                shell = { 'shfmt' },
                sh = { 'shfmt' },
                javascript = { lsp_format = 'prefer' },
                typescript = { lsp_format = 'prefer' },
                go = { 'goimports', 'gofmt' },
            },
            format_on_save = function(bufnr)
                local ignore_filetypes = {
                    'sql',
                    'typescript', -- handled by eslint
                    'javascript', -- handled by eslint
                }

                if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then return end
                if vim.b.autofmt == false then return end

                local bufname = vim.api.nvim_buf_get_name(bufnr)
                if bufname:match('/node_modules/') then return end

                return { timeout_ms = 1000, lsp_format = 'never' }
            end,
        })
    end,
    keys = {
        { '<leader>f', function() require('conform').format() end, desc = 'Format' },
    },
}
