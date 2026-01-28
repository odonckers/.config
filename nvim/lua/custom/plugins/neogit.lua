return {
    'NeogitOrg/neogit',
    dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim', 'ibhagwan/fzf-lua' },
    cmd = 'Neogit',
    keys = {
        { '<leader>gg', function() require('neogit').open() end, desc = 'Show Neogit UI' },
    },
}
