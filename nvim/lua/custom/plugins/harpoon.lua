return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        settings = {
            save_on_toggle = true,
            sync_on_ui_close = true,
        },
    },
    config = function(_, opts)
        local harpoon = require('harpoon')
        harpoon:setup(opts)

        local harpoon_extensions = require('harpoon.extensions')
        harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
    end,
    keys = {
        {
            '<leader>h',
            function()
                local harpoon = require('harpoon')
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
            desc = 'Open harpoon list',
            noremap = true,
            silent = true,
        },
        {
            '<leader>H',
            function() require('harpoon'):list():add() end,
            desc = 'Add file to harpoon list',
        },
        { 'g1', function() require('harpoon'):list():select(1) end, desc = 'Harpoon 1' },
        { 'g2', function() require('harpoon'):list():select(2) end, desc = 'Harpoon 2' },
        { 'g3', function() require('harpoon'):list():select(3) end, desc = 'Harpoon 3' },
        { 'g4', function() require('harpoon'):list():select(4) end, desc = 'Harpoon 4' },
        { 'g5', function() require('harpoon'):list():select(5) end, desc = 'Harpoon 5' },
        { 'g6', function() require('harpoon'):list():select(6) end, desc = 'Harpoon 6' },
        { 'g7', function() require('harpoon'):list():select(7) end, desc = 'Harpoon 7' },
        { 'g8', function() require('harpoon'):list():select(8) end, desc = 'Harpoon 8' },
        { 'g9', function() require('harpoon'):list():select(9) end, desc = 'Harpoon 9' },
        { ']h', function() require('harpoon'):list():next() end, desc = 'Next harpoon' },
        { '[h', function() require('harpoon'):list():prev() end, desc = 'Previous harpoon' },
    },
}
