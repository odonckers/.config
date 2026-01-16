return {
    'folke/sidekick.nvim',
    opts = {
        cli = {
            win = {
                layout = 'float',
                float = {
                    width = 102, -- 2 (decorations) + 100
                    border = 'rounded',
                },
            },
        },
    },
    init = function()
        -- blink.cmp
        vim.api.nvim_create_autocmd('User', {
            pattern = 'BlinkCmpMenuOpen',
            callback = function() vim.b.copilot_suggestion_hidden = true end,
        })
        vim.api.nvim_create_autocmd('User', {
            pattern = 'BlinkCmpMenuClose',
            callback = function() vim.b.copilot_suggestion_hidden = false end,
        })
    end,
    keys = {
        {
            '<tab>',
            function()
                if not require('sidekick').nes_jump_or_apply() then return '<Tab>' end
            end,
            expr = true,
            desc = 'Goto/Apply Next Edit Suggestion',
        },
        {
            '<c-.>',
            function() require('sidekick.cli').toggle({ filter = { installed = true } }) end,
            desc = 'Sidekick Toggle',
            mode = { 'n', 't', 'i', 'x' },
        },
        {
            '<leader>aa',
            function() require('sidekick.cli').toggle() end,
            desc = 'Sidekick Toggle CLI',
        },
        {
            '<leader>as',
            function() require('sidekick.cli').select({ filter = { installed = true } }) end,
            desc = 'Select CLI',
        },
        {
            '<leader>ad',
            function() require('sidekick.cli').close() end,
            desc = 'Detach a CLI Session',
        },
        {
            '<leader>at',
            function() require('sidekick.cli').send({ msg = '{this}' }) end,
            mode = { 'x', 'n' },
            desc = 'Send This',
        },
        {
            '<leader>af',
            function() require('sidekick.cli').send({ msg = '{file}' }) end,
            desc = 'Send File',
        },
        {
            '<leader>av',
            function() require('sidekick.cli').send({ msg = '{selection}' }) end,
            mode = { 'x' },
            desc = 'Send Visual Selection',
        },
        {
            '<leader>ap',
            function() require('sidekick.cli').prompt() end,
            mode = { 'n', 'x' },
            desc = 'Sidekick Select Prompt',
        },
    },
}
