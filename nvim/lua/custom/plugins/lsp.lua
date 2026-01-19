return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        { 'folke/lazydev.nvim', ft = 'lua', config = true }, -- Lua Neovim APIs
        { 'GustavEikaas/easy-dotnet.nvim', dependencies = { 'nvim-lua/plenary.nvim' } }, -- C# / .NET
        { 'antosha417/nvim-lsp-file-operations', dependencies = { 'nvim-lua/plenary.nvim' } }, -- Filetree LSP operations
        'stevearc/conform.nvim', -- Formatting
    },
    config = function()
        require('lsp-file-operations').setup()

        -- LuaLS/lua-language-server
        vim.lsp.config('lua_ls', {
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

        -- npm:vscode-langservers-extracted
        vim.lsp.enable('html')
        vim.lsp.enable('cssls')
        vim.lsp.enable('jsonls')
        vim.lsp.config('eslint', {
            settings = {
                useESLintClass = false,
                experimental = { useFlatConfig = true },
            },
        })
        vim.lsp.enable('eslint')

        -- npm:@vtsls/language-server
        vim.lsp.enable('vtsls')

        -- npm:@angular/language-server
        vim.lsp.enable('angularls')

        -- dotnet
        require('easy-dotnet').setup()

        -- npm:@github/copilot-language-server
        vim.lsp.enable('copilot')

        -- macOS:SourceKit (for swift)
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
