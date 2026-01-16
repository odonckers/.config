return {
    'smjonas/inc-rename.nvim',
    main = 'inc_rename',
    config = true,
    keys = {
        {
            'grn',
            function() return ':IncRename ' .. vim.fn.expand('<cword>') end,
            desc = 'Rename symbol',
            expr = true,
            silent = true,
        },
    },
}
