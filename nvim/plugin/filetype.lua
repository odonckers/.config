local igroup = vim.api.nvim_create_augroup('IndentationConfig', {})

vim.api.nvim_create_autocmd('FileType', {
    group = igroup,
    pattern = { 'text', 'plaintex', 'typst', 'gitcommit', 'markdown', 'md' },
    callback = function()
        vim.opt_local.spell = true
        -- vim.opt_local.wrap = true

        vim.opt_local.colorcolumn = '120'
        -- vim.opt_local.textwidth = 120
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    group = igroup,
    pattern = { 'lua', 'python' },
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    group = igroup,
    pattern = { 'javascript', 'typescript', 'json', 'html', 'css' },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    group = igroup,
    pattern = { 'javascript', 'typescript' },
    callback = function() vim.opt_local.colorcolumn = '140' end,
})

vim.api.nvim_create_autocmd('FileType', {
    group = igroup,
    pattern = { 'c', 'csharp' },
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
    end,
})
