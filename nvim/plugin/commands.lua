-- Set relative number
vim.api.nvim_create_user_command('SetRelativeNumber', function()
    vim.g.relativenumber = true
    vim.opt.relativenumber = vim.g.relativenumber
    vim.notify('Enabled relative line numbers')
end, {})
vim.api.nvim_create_user_command('SetNoRelativeNumber', function()
    vim.g.relativenumber = false
    vim.opt.relativenumber = vim.g.relativenumber
    vim.notify('Disabled relative line numbers')
end, {})

-- Set virtual lines
vim.api.nvim_create_user_command('SetVirtualLines', function()
    vim.diagnostic.config({
        virtual_lines = { current_line = true },
        virtual_text = false,
    })
    vim.notify('Enabled LSP virtual lines ')
end, {})
vim.api.nvim_create_user_command('SetNoVirtualLines', function()
    vim.diagnostic.config({
        virtual_lines = false,
        virtual_text = { current_line = true },
    })
    vim.notify('Disabled LSP virtual lines')
end, {})

-- Set inlay hints
vim.api.nvim_create_user_command('SetInlayHints', function()
    vim.lsp.inlay_hint.enable(true)
    vim.notify('Enabled LSP inlay hints')
end, {})
vim.api.nvim_create_user_command('SetNoInlayHints', function()
    vim.lsp.inlay_hint.enable(false)
    vim.notify('Disabled LSP inlay hints')
end, {})

-- Set auto format
vim.api.nvim_create_user_command('SetAutoFormat', function()
    vim.b.autofmt = true
    vim.notify('Enabled auto format for this buffer')
end, {})
vim.api.nvim_create_user_command('SetNoAutoFormat', function()
    vim.b.autofmt = false
    vim.notify('Disabled auto format for this buffer')
end, {})
