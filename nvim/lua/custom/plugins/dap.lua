local function load_launch_settings(project_path)
    local launch_settings_path = project_path .. '/Properties/launchSettings.json'
    local file = io.open(launch_settings_path, 'r')
    if not file then
        vim.notify('launchSettings.json not found at: ' .. launch_settings_path, vim.log.levels.WARN)
        return nil
    end

    local content = file:read('*all')
    file:close()

    local ok, data = pcall(vim.json.decode, content)
    if not ok then
        vim.notify('Failed to parse launchSettings.json', vim.log.levels.ERROR)
        return nil
    end

    -- Get first profile's environment variables
    local profiles = data.profiles or {}
    for _, profile in pairs(profiles) do
        if profile.environmentVariables then return profile.environmentVariables end
    end

    return nil
end

local function get_dll_info()
    if vim.g.dotnet_dll_info == nil then vim.g.dotnet_dll_info = require('easy-dotnet').get_debug_dll() end
    print(vim.g.dotnet_dll_info)
    return vim.g.dotnet_dll_info
end

return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        'jay-babu/mason-nvim-dap.nvim',
        'theHamsta/nvim-dap-virtual-text',

        -- dotnet
        'Cliffback/netcoredbg-macOS-arm64.nvim',
        'GustavEikaas/easy-dotnet.nvim',
    },
    config = function()
        local dap = require('dap')
        -- dap.set_log_level('TRACE')

        require('nvim-dap-virtual-text').setup()
        require('mason-nvim-dap').setup({
            ensure_installed = { 'netcoredbg' },
            automatic_installation = true,
            handlers = {
                function(config) require('mason-nvim-dap').default_setup(config) end,
            },
        })

        -- require('easy-dotnet.netcoredbg').register_dap_variables_viewer()
        -- require('netcoredbg-macOS-arm64').setup(dap)

        dap.adapters.coreclr = {
            type = 'executable',
            command = vim.fn.stdpath('data') .. '/lazy/netcoredbg-macOS-arm64.nvim/netcoredbg/netcoredbg',
            args = { '--interpreter=vscode' },
        }

        dap.configurations.cs = {
            {
                type = 'coreclr',
                name = 'launch - easy-dotnet',
                request = 'launch',
                env = function()
                    local dll_info = get_dll_info()
                    local env_vars = load_launch_settings(dll_info.project_path)
                    -- env_vars.__VSCODE_DOTNET_DIAGNOSTIC_LOGGING = '1'
                    return env_vars or { ASPNETCORE_ENVIRONMENT = 'Development' }
                end,
                program = function() return get_dll_info().dll_path end,
                cwd = function() return get_dll_info().project_path end,
                -- justMyCode = false,
                -- stopAtEntry = false,
                -- console = 'internalConsole',
            },
            {
                type = 'coreclr',
                name = 'launch - netcoredbg',
                request = 'launch',
                program = function() return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file') end,
            },
            {
                type = 'coreclr',
                name = 'attach - netcoredbg',
                request = 'attach',
                processId = require('dap.utils').pick_process,
            },
        }

        local ui = require('dapui')
        ui.setup()

        vim.fn.sign_define('DapBreakpoint', { text = '●' })
        vim.fn.sign_define('DapBreakpointCondition', { text = '◆' })
        vim.fn.sign_define('DapBreakpointRejected', { text = '○' })
        vim.fn.sign_define('DapLogPoint', { text = '◎' })
        vim.fn.sign_define('DapStopped', {
            text = '→',
            texthl = 'DapStopped',
            linehl = 'DapStoppedLine',
            numhl = 'DapStopped',
        })

        vim.api.nvim_set_hl(0, 'DapBreakpoint', { link = 'ErrorMsg' })
        vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { link = 'ErrorMsg' })
        vim.api.nvim_set_hl(0, 'DapBreakpointRejected', { link = 'ErrorMsg' })
        vim.api.nvim_set_hl(0, 'DapLogPoint', { link = 'ErrorMsg' })
        vim.api.nvim_set_hl(0, 'DapStopped', { link = 'ErrorMsg' })
        vim.api.nvim_set_hl(0, 'DapStoppedLine', { link = 'Visual' })

        dap.listeners.before.attach.dapui_config = function() ui.open() end
        dap.listeners.before.launch.dapui_config = function() ui.open() end
        dap.listeners.before.event_terminated.dapui_config = function()
            vim.g.dotnet_dll_info = nil
            ui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            vim.g.dotnet_dll_info = nil
            ui.close()
        end
    end,
    keys = {
        {
            '<leader>dt',
            function() require('dap').toggle_breakpoint() end,
            desc = 'Toggle Breakpoint',
        },
        {
            '<leader>dc',
            function() require('dap').continue() end,
            desc = 'Continue',
        },
        {
            '<leader>di',
            function() require('dap').step_into() end,
            desc = 'Step Into',
        },
        {
            '<leader>do',
            function() require('dap').step_over() end,
            desc = 'Step Over',
        },
        {
            '<leader>du',
            function() require('dap').step_out() end,
            desc = 'Step Out',
        },
        {
            '<leader>dr',
            function() require('dap').repl.open() end,
            desc = 'Open REPL',
        },
        {
            '<leader>dl',
            function() require('dap').run_last() end,
            desc = 'Run Last',
        },
        {
            '<leader>dq',
            function()
                require('dap').terminate()
                require('dapui').close()
                require('nvim-dap-virtual-text').toggle()
            end,
            desc = 'Terminate',
        },
        {
            '<leader>db',
            function() require('dap').list_breakpoints() end,
            desc = 'List Breakpoints',
        },
        {
            '<leader>de',
            function() require('dap').set_exception_breakpoints({ 'all' }) end,
            desc = 'Set Exception Breakpoints',
        },
    },
}
