return {
    'folke/which-key.nvim',
    lazy = false,
    opts = {
        preset = 'helix',
        spec = {
            { '<leader>a', group = 'AI', mode = { 'n', 't', 'i', 'x' } },
            {
                '<leader>b',
                group = 'Buffers',
                expand = function() return require('which-key.extras').expand.buf() end,
            },
            { '<leader>c', group = 'Quickfix list' },
            { '<leader>d', group = 'Diagnostics' },
            { '<leader>g', group = 'Git' },
            { '<leader>n', group = 'Notes' },
            { '<leader>t', group = 'Test' },
            { '<leader>w', proxy = '<C-w>', group = 'Windows' },
        },
    },
    config = function(_, opts) require('which-key').setup(opts) end,
}
