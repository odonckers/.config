vim.lsp.enable({
    'lua_ls', -- aqua:LuaLS/lua-language-server
    'vtsls', -- npm:@vtsls/language-server
    'angularls', -- npm:@angular/language-server
    'copilot', -- npm:@github/copilot-language-server
    'sourcekit', -- macOS:SourceKit

    -- npm:vscode-langservers-extracted
    'html',
    'cssls',
    'jsonls',
    'eslint',
})

vim.diagnostic.config({
    float = {
        border = 'rounded',
        focusable = true,
    },
    virtual_lines = false,
    virtual_text = true,
    underline = { severity = vim.diagnostic.severity.WARN },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.HINT] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
        },
        texthl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
            [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.HINT] = '',
            [vim.diagnostic.severity.INFO] = '',
        },
    },
})
