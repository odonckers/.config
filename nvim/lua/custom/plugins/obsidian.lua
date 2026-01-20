return {
    'obsidian-nvim/obsidian.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'ibhagwan/fzf-lua',
    },
    lazy = true,
    ft = 'markdown',
    opts = {
        legacy_commands = false, -- this will be removed in the next major release
        workspaces = {
            {
                name = 'OwenOS',
                path = '~/Documents/OwenOS',
            },
        },
    },
    cmd = 'Obsidian',
    keys = {
        -- Top level commands
        { '<leader>n<leader>', '<cmd>Obsidian quick_switch<cr>', desc = 'Quick switch', silent = true },
        { '<leader>nn', '<cmd>Obsidian new<cr>', desc = 'New note', silent = true },
        { '<leader>ns', '<cmd>Obsidian search<cr>', desc = 'Search notes', silent = true },
        { '<leader>nw', '<cmd>Obsidian workspace<cr>', desc = 'Switch workspaces', silent = true },

        -- Note commands
        { '<leader>nb', '<cmd>Obsidian backlinks<cr>', desc = 'Goto backlinks', silent = true },
        { '<leader>nc', '<cmd>Obsidian toc<cr>', desc = 'Search table of contents for note', silent = true },
        { '<leader>nd', '<cmd>Obsidian dailies<cr>', desc = 'Search daily notes', silent = true },
        { '<leader>nI', '<cmd>Obsidian paste_img<cr>', desc = 'Paste image at cursor', silent = true },
        { '<leader>nl', '<cmd>Obsidian links<cr>', mode = 'n', desc = 'Links in note', silent = true },
        { '<leader>no', '<cmd>Obsidian follow_link<cr>', desc = 'Open/follow link under cursor', silent = true },
        { '<leader>nr', '<cmd>Obsidian rename<cr>', desc = 'Rename note or link under cursor', silent = true },
        { '<leader>nt', '<cmd>Obsidian today<cr>', desc = 'Open todays note', silent = true },
        { '<leader>ny', '<cmd>Obsidian yesterday<cr>', desc = 'Open yesterdays note', silent = true },

        -- Visual mode commands
        {
            '<leader>ne',
            '<cmd>Obsidian extract_note<cr>',
            mode = 'v',
            desc = 'Extract selection into new note',
            silent = true,
        },
        {
            '<leader>nl',
            '<cmd>Obsidian link<cr>',
            mode = 'v',
            desc = 'Link selection to an existing note',
            silent = true,
        },
        { '<leader>nL', ':Obsidian link_new ', mode = 'v', desc = 'Link selection to a new note', silent = true },
    },
}
