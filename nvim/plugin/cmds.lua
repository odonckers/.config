-- Toggle auto formatting
vim.api.nvim_create_user_command('ToggleAutoFormatting', function()
    vim.b.autofmt = not vim.b.autofmt
    vim.notify('Toggled auto format ' .. (vim.b.autofmt and 'on' or 'off') .. ' for this buffer')
end, {})

-- Toggle relative line numbers
vim.api.nvim_create_user_command('ToggleRelativeLineNumbers', function()
    vim.g.relativenumber = not (vim.g.relativenumber or vim.opt.relativenumber:get())
    vim.opt.relativenumber = vim.g.relativenumber
    vim.notify('Toggled relative line numbers ' .. (vim.g.relativenumber and 'on' or 'off'))
end, {})

-- Toggle between expr and indent folding
vim.api.nvim_create_user_command('ToggleFoldMethod', function()
    local current = vim.opt_local.foldmethod:get()
    local new_method = current == 'expr' and 'indent' or 'expr'
    vim.opt_local.foldmethod = new_method
    vim.notify('Toggled fold method to ' .. new_method)
end, {})

-- Toggle LSP virtual lines
vim.api.nvim_create_user_command('ToggleLspVirtualLines', function()
    local current = vim.diagnostic.config() or {}
    local enabled = current.virtual_lines ~= false and current.virtual_lines ~= nil
    vim.diagnostic.config({
        virtual_lines = not enabled and { current_line = true } or false,
        virtual_text = enabled and { current_line = true } or false,
    })
    vim.notify('Toggled LSP virtual lines ' .. (not enabled and 'on' or 'off'))
end, {})

-- Toggle LSP inlay hints
vim.api.nvim_create_user_command('ToggleLspInlayHints', function()
    local enabled = not vim.lsp.inlay_hint.is_enabled()
    vim.lsp.inlay_hint.enable(enabled)
    vim.notify('Toggled LSP inlay hints ' .. (enabled and 'on' or 'off'))
end, {})
