local version = false
return {
    -- Text editing
    { 'nvim-mini/mini.move', version = version, config = true }, -- Move any selection in any direction
    { 'nvim-mini/mini.surround', version = version, config = true }, -- Surround actions

    -- General workflow
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
    { 'nvim-mini/mini.starter', version = version, config = true }, -- Start screen
    { 'nvim-mini/mini.statusline', version = version, config = true }, -- Statusline
    { 'nvim-mini/mini.tabline', version = version, config = true }, -- Tabline
}
