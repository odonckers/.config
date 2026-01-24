return {
    'nvim-neotest/neotest',
    dependencies = {
        'nvim-neotest/nvim-nio',
        'nvim-lua/plenary.nvim',
        'antoinemadec/FixCursorHold.nvim',
        'nvim-treesitter/nvim-treesitter',

        -- Language support
        'nvim-neotest/neotest-jest', -- jest
        'nsidorenco/neotest-vstest', -- dotnet
    },
    config = function()
        require('neotest').setup({
            adapters = {
                require('neotest-jest')(),
                require('neotest-vstest'),
            },
        })
    end,
    keys = {
        -- Run
        { '<leader>trr', function() require('neotest').run.run() end, desc = 'Run the nearest test' },
        { '<leader>trf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Run the current file' },
        -- TODO: Requires nvim-dap
        -- {
        --     '<leader>trd',
        --     function() require('neotest').run.run({ strategy = 'dap' }) end,
        --     desc = 'Debug the nearest test',
        -- },
        { '<leader>trs', function() require('neotest').run.stop() end, desc = 'Stop the nearest test' },
        { '<leader>tra', function() require('neotest').run.attach() end, desc = 'Attach to the nearest test' },

        -- Consumers
        { '<leader>tw', function() require('neotest').watch() end, desc = 'Watch files related to tests' },
        { '<leader>to', function() require('neotest').output() end, desc = 'Open output window of nearest test' },
        { '<leader>tp', function() require('neotest').output_panel() end, desc = 'Open ouput panel of tests' },

        -- Summary
        {
            '<leader>tst',
            function() require('neotest').summary.toggle() end,
            desc = 'Open summary panel of project tests',
        },
        -- {
        --     '<leader>tso',
        --     function() require('neotest').summary.expand end,
        --     desc = 'Open summary panel of project tests',
        -- },
    },
}
