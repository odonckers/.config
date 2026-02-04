return {
    'folke/which-key.nvim',
    lazy = false,
    opts = {
        preset = 'helix',
        icons = { mappings = false },
        spec = {
            {
                '<leader>b',
                group = 'Buffers',
                expand = function() return require('which-key.extras').expand.buf() end,
            },
            { '<leader>c', group = 'Quickfix list' },
            { '<leader>d', group = 'Diagnostics' },
            { '<leader>g', group = 'Git' },
            { '<leader>gt', group = 'Toggle' },
            { '<leader>n', group = 'No Neck Pain' },
            { '<leader>o', group = 'Obsidian' },
            { '<leader>t', group = 'Test' },
            { '<leader>tr', group = 'Run' },
            { '<leader>w', proxy = '<C-w>', group = 'Windows' },
        },
    },
    config = function(_, opts) require('which-key').setup(opts) end,
}
