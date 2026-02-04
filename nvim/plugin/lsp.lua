vim.lsp.enable({
    'lua_ls', -- LuaLS/lua-language-server
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

vim.lsp.inlay_hint.enable(true)

vim.diagnostic.config({
    float = {
        border = 'rounded',
        focusable = true,
    },
    virtual_lines = false,
    virtual_text = { current_line = true },
    underline = { severity = vim.diagnostic.severity.WARN },
})
