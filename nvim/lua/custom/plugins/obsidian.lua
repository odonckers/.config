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
    keys = {
        -- Top level commands
        { '<leader>nn', '<cmd>Obsidian new<cr>', desc = 'New note' },
        { '<leader>ns', '<cmd>Obsidian search<cr>', desc = 'Search notes' },
        { '<leader>nw', '<cmd>Obsidian workspace<cr>', desc = 'Switch workspaces' },

        -- Note commands
        { '<leader>nb', '<cmd>Obsidian backlinks<cr>', desc = 'Goto backlinks' },
        { '<leader>nc', '<cmd>Obsidian toggle_checkbox<cr>', desc = 'Cycle checkbox under cursor' },
        { '<leader>nI', '<cmd>Obsidian paste_img<cr>', desc = 'Paste image at cursor' },
        { '<leader>nl', '<cmd>Obsidian links<cr>', mode = 'n', desc = 'Links in note' },
        { '<leader>no', '<cmd>Obsidian follow_link<cr>', desc = 'Open/follow link under cursor' },
        { '<leader>nr', '<cmd>Obsidian rename<cr>', desc = 'Rename note or link under cursor' },
        { '<leader>nt', '<cmd>Obsidian toc<cr>', desc = 'Search table of contents for note' },

        -- Visual mode commands
        { '<leader>ne', '<cmd>Obsidian extract_note<cr>', mode = 'v', desc = 'Extract selection into new note' },
        { '<leader>nl', '<cmd>Obsidian link<cr>', mode = 'v', desc = 'Link selection to an existing note' },
        { '<leader>nL', ':Obsidian link_new ', mode = 'v', desc = 'Link selection to a new note' },
    },
}
