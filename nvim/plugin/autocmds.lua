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

-- Add leading lines for indentation
local function update_leadmultispace(is_local)
    local opt = is_local and vim.opt_local or vim.opt
    ---@diagnostic disable-next-line: undefined-field
    local shiftwidth = opt.shiftwidth:get()
    if shiftwidth == 0 then
        ---@diagnostic disable-next-line: undefined-field
        shiftwidth = opt.tabstop:get()
    end
    local listchars = opt.listchars:get()
    local pattern = vim.g.indentline_char .. string.rep(vim.g.lead_char, shiftwidth - 1)
    listchars.leadmultispace = pattern
    opt.listchars = listchars
end

vim.api.nvim_create_autocmd('OptionSet', {
    pattern = 'shiftwidth',
    callback = function() update_leadmultispace(vim.v.option_type == 'local') end,
    desc = 'Update leadmultispace when shiftwidth changes',
})
vim.api.nvim_create_autocmd({ 'BufEnter', 'FileType' }, {
    callback = function()
        -- Delay slightly to ensure filetype settings have been applied
        vim.schedule(update_leadmultispace)
    end,
    desc = 'Update leadmultispace on buffer enter',
})
