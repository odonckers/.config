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
        { 'mrcjkb/rustaceanvim', version = '^7', lazy = false },
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
                { name = 'lazydev', group_index = 0 },
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

        -- Setup LSP capabilities for CMP
        local capabilities = vim.tbl_deep_extend(
            'force',
            vim.lsp.protocol.make_client_capabilities(),
            require('cmp_nvim_lsp').default_capabilities()
        )
        vim.lsp.config('*', { capabilities = capabilities })

        -- Setup LSP file operations
        require('lsp-file-operations').setup()

        -- Setup dotnet
        local easy_dotnet = require('easy-dotnet')
        easy_dotnet.setup()
        cmp.register_source('easy-dotnet', easy_dotnet.package_completion_source)

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
