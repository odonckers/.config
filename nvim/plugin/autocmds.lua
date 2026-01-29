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
