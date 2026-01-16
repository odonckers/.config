return {
    'rose-pine/neovim',
    name = 'rose-pine',
    enabled = false,
    opts = {
        enable = {
            legacy_highlights = false,
        },
        styles = {
            bold = true,
            italic = false,
            transparency = true,
        },
    },
    config = function(_, opts)
        require('rose-pine').setup(opts)
        vim.cmd('colorscheme rose-pine')
    end,
}
