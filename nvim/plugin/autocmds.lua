-- Configure auto formatting for each buffer created
local afgroup = vim.api.nvim_create_augroup('AutoFormattingConfig', {})
vim.api.nvim_create_autocmd('FileType', {
    group = afgroup,
    pattern = '*',
    callback = function()
        if vim.bo.filetype == 'json' then
            vim.b.autofmt = false
        else
            vim.b.autofmt = true
        end
    end,
})
vim.api.nvim_create_autocmd('FileType', {
    group = afgroup,
    pattern = { 'json', 'css', 'scss' },
    callback = function() vim.b.autofmt = false end,
})

-- Disable relative line numbers on insert mode if enabled
local rlngroup = vim.api.nvim_create_augroup('RelativeLineNumbersConfig', {})
vim.api.nvim_create_autocmd('InsertEnter', {
    group = rlngroup,
    callback = function()
        vim.g.relativenumber = vim.g.relativenumber or vim.opt.relativenumber:get()
        vim.opt.relativenumber = false
    end,
})
vim.api.nvim_create_autocmd('InsertLeave', {
    group = rlngroup,
    callback = function() vim.opt.relativenumber = vim.g.relativenumber end,
})

-- Set conceal level in markdown to 1 to use pretty formatting
local clgroup = vim.api.nvim_create_augroup('MarkdownConcealLevelConfig', {})
vim.api.nvim_create_autocmd('FileType', {
    group = clgroup,
    pattern = { 'markdown', 'md' },
    callback = function()
        -- Completely hide concealed text unless it has a custom replacement character defined
        vim.opt_local.conceallevel = 2
    end,
})
