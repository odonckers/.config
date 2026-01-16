return {
    'stevearc/oil.nvim',
    lazy = false,
    opts = {
        view_options = {
            show_hidden = true,
        },
        keymaps = {
            ['<C-s>'] = false,
            ['<C-h>'] = false,
            ['<C-t>'] = false,
            ['<C-p>'] = false,
            ['<C-c>'] = false,
            ['<C-l>'] = false,
            ['<C-r>'] = 'actions.refresh',
        },
    },
    keys = {
        { '<C-e>', '<cmd>Oil<cr>', desc = 'Open files', silent = true },
        { '<leader><space>', '<cmd>Oil<cr>', desc = 'Open files', silent = true },
    },
}
