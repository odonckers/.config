return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        -- Configure Lua LSP for neovim config and apis
        { 'folke/lazydev.nvim', ft = 'lua', config = true },

        -- LSP installer
        'mason-org/mason.nvim',
        'mason-org/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',

        -- Filetree LSP operations
        {
            'antosha417/nvim-lsp-file-operations',
            dependencies = { 'nvim-lua/plenary.nvim' },
        },

        -- Autoformat
        'stevearc/conform.nvim',

        -- C# / .NET
        {
            'GustavEikaas/easy-dotnet.nvim',
            dependencies = { 'nvim-lua/plenary.nvim' },
        },
    },
    config = function()
        -- Setup Mason
        require('mason').setup({
            registries = { 'github:mason-org/mason-registry', 'github:Crashdummyy/mason-registry' },
            ui = { border = 'rounded' },
        })

        -- Filetree LSP operations
        require('lsp-file-operations').setup()

        -- Configure installed LSPs
        local ensure_installed_servers = {
            -- Lua
            'lua_ls',

            -- Web
            'html',
            'cssls',
            'vtsls',
            'eslint',
            'angularls',

            -- PHP
            'phpactor',

            -- Data
            'jsonls',
            'graphql',

            -- AI
            'copilot',
        }
        require('mason-lspconfig').setup({ ensure_installed = ensure_installed_servers })

        local ensure_installed_tools = { 'stylua', 'lua_ls' }
        vim.list_extend(ensure_installed_tools, ensure_installed_servers)
        require('mason-tool-installer').setup({ ensure_installed = ensure_installed_tools })

        -- Lua
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

        -- C# / .NET
        require('easy-dotnet').setup({
            debugger = {
                bin_path = vim.fs.joinpath(vim.fn.stdpath('data'), 'mason/bin/netcoredbg'),
            },
        })

        -- Swift (Apple SourceKit LSP)
        -- Requires being on macOS
        vim.lsp.enable('sourcekit')

        -- Autoformat
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
        { '<leader>m', '<cmd>Mason<cr>', desc = 'Open mason', silent = true },
        { '<leader>f', function() require('conform').format() end, desc = 'Format' },
    },
}
