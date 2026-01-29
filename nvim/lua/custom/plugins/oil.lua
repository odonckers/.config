return {
    'stevearc/oil.nvim',
    lazy = false,
    opts = {
        view_options = { show_hidden = true },
        keymaps = {
            ['<C-h>'] = false,
            ['<C-l>'] = false,
        },
    },
    keys = {
        { '<leader><space>', '<cmd>Oil<cr>', desc = 'Open files', silent = true },
    },
}
