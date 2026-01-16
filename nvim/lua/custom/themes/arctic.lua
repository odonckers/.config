return {
    'rockyzhang24/arctic.nvim',
    dependencies = { 'rktjmp/lush.nvim' },
    branch = 'v2',
    name = 'arctic',
    priority = 1000,
    enabled = false,
    config = function()
        vim.cmd.colorscheme('arctic')

        vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })

        -- vim.api.nvim_set_hl(0, 'NonText', { bg = 'none' })
        -- vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })
        -- vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })
        -- vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
    end,
}
