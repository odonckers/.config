-- Toggle auto formatting
vim.api.nvim_create_user_command('ToggleAutoFormatting', function()
    vim.b.autofmt = (vim.b.autofmt or false) == false
    if vim.b.autofmt then
        vim.notify('Toggled auto format on for this buffer')
    else
        vim.notify('Toggled auto format off for this buffer')
    end
end, {})

-- Toggle relative line numbers
vim.api.nvim_create_user_command('ToggleRelativeLineNumbers', function()
    vim.g.relativenumber = (vim.g.relativenumber or vim.opt.relativenumber:get()) == false
    vim.opt.relativenumber = vim.g.relativenumber
    if vim.g.relativenumber then
        vim.notify('Toggled relative line numbers on')
    else
        vim.notify('Toggled relative line numbers off')
    end
end, {})

-- Toggle spell check
vim.api.nvim_create_user_command('ToggleSpellCheck', function()
    ---@diagnostic disable-next-line: undefined-field
    vim.opt_local.spell = (vim.opt_local.spell:get() or false) == false
    if vim.opt_local.spell then
        vim.notify('Toggled spell check on for this buffer')
    else
        vim.notify('Toggled spell check off for this buffer')
    end
end, {})

-- Toggle word wrap
vim.api.nvim_create_user_command('ToggleWordWrap', function()
    ---@diagnostic disable-next-line: undefined-field
    vim.opt_local.wrap = (vim.opt_local.wrap:get() or false) == false
    if vim.opt_local.wrap then
        vim.notify('Toggled word wrap on for this buffer')
    else
        vim.notify('Toggled word wrap off for this buffer')
    end
end, {})

-- Toggle LSP virtual lines
vim.api.nvim_create_user_command('ToggleLspVirtualLines', function()
    local virtuallines = (vim.g.virtual_lines or true) == false
    vim.g.virtual_lines = virtuallines

    local opts = {}
    if virtuallines then
        opts.virtual_lines = { current_line = true }
        opts.virtual_text = false
        vim.notify('Toggled virtual lines on')
    else
        opts.virtual_lines = false
        opts.virtual_text = { current_line = true }
        vim.notify('Toggled virtual lines off')
    end
    vim.diagnostic.config(opts)
end, {})

-- Toggle LSP inlay hints
vim.api.nvim_create_user_command('ToggleLspInlayHints', function()
    local enabled = not vim.lsp.inlay_hint.is_enabled()
    vim.lsp.inlay_hint.enable(enabled)
    vim.notify('Toggled LSP inlay hints ' .. (enabled and 'on' or 'off'))
end, {})
