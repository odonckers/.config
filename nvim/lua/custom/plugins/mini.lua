local version = false
return {
    -- Text editing
    { 'nvim-mini/mini.comment', version = version, config = true }, -- Comment lines
    { 'nvim-mini/mini.move', version = version, config = true }, -- Move any selection in any direction
    { 'nvim-mini/mini.surround', version = version, config = true }, -- Surround actions

    -- General workflow
    { 'nvim-mini/mini.bracketed', version = version, config = true }, -- Go forward/backward with square brackets
    { 'nvim-mini/mini.bufremove', version = version, config = true }, -- Remove buffers
    {
        'nvim-mini/mini.diff', -- Work with diff hunks
        version = version,
        opts = {
            view = {
                signs = { add = '┃', change = '┃', delete = '┃' },
            },
        },
    },
    { 'nvim-mini/mini.sessions', version = version, config = true }, -- Session management

    -- Appearance
    { 'nvim-mini/mini.icons', version = version, config = true }, -- Icon provider
    { 'nvim-mini/mini.indentscope', version = version, config = true }, -- Visualize and work with indent scope
    {
        'nvim-mini/mini.notify', -- Show notifications
        version = version,
        opts = {
            window = {
                -- Works around an odd behavior with winblend and transparency
                -- https://github.com/neovim/neovim/issues/10685#issuecomment-2234012682
                winblend = 0,
            },
        },
    },
    { 'nvim-mini/mini.starter', version = version, config = true }, -- Start screen
    { 'nvim-mini/mini.statusline', version = version, config = true }, -- Statusline
    { 'nvim-mini/mini.tabline', version = version, config = true }, -- Tabline
}
