---@module "lazy"
---@type LazySpec
return {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = true,
    keys = function()
        local Terminal = require('toggleterm.terminal').Terminal
        local lazygit = Terminal:new({ cmd = 'lazygit', hidden = true, display_name = 'Lazygit' })

        return {
            { '<leader>gl', function() lazygit:toggle(nil, 'float') end, desc = 'Toggle Lazygit' },
        }
    end,
}
