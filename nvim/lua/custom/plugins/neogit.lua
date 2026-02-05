---@module "lazy"
---@type LazySpec
return {
    'NeogitOrg/neogit',
    dependencies = {
        'nvim-lua/plenary.nvim', -- required
        'sindrets/diffview.nvim', -- optional - diff integration
        'ibhagwan/fzf-lua', -- one picker is required
    },
    cmd = 'Neogit',
    keys = {
        { '<leader>gg', function() require('neogit').open({ kind = 'floating' }) end, desc = 'Show Neogit UI' },
    },
}
