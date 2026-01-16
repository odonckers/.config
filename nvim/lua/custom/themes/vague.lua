return {
    'vague-theme/vague.nvim',
    lazy = false,
    priority = 1000,
    enabled = true,
    opts = {
        style = {
            strings = 'none',
            keyword_return = 'bold',
            keywords_exception = 'bold',
        },
    },
    config = function(_, opts)
        require('vague').setup(opts)
        vim.cmd('colorscheme vague')
    end,
}
