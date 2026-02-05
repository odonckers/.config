---@module "lazy"
---@type LazySpec
return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-mini/mini.icons' },
    lazy = false, -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    ---@module 'oil'
    ---@type oil.SetupOpts
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
