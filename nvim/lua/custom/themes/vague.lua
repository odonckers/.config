return {
    'vague-theme/vague.nvim',
    lazy = false,
    priority = 1000,
    enabled = true,
    opts = {
        transparent = true,
        style = {
            strings = 'none',
        },
    },
    config = function(_, opts)
        require('vague').setup(opts)
        vim.cmd('colorscheme vague')
    end,
}
