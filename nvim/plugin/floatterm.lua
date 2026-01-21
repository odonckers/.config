-- State management: stores all floating terminal instances
local terminals = {}
local last_terminal = nil

-- Calculate floating window dimensions
local function get_float_dimensions()
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)
    return {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded',
    }
end

-- Kill terminal completely (delete buffer and remove from state)
local function kill(name)
    name = name or last_terminal or 'default'
    local terminal = terminals[name]

    if not terminal then return end
    if vim.api.nvim_win_is_valid(terminal.win) then vim.api.nvim_win_close(terminal.win, true) end
    if vim.api.nvim_buf_is_valid(terminal.buf) then vim.api.nvim_buf_delete(terminal.buf, { force = true }) end

    terminals[name] = nil
    if last_terminal == name then last_terminal = nil end
end

-- Close terminal by name
local function close(name)
    name = name or last_terminal or 'default'
    local terminal = terminals[name]
    if not terminal then return end

    -- Close the window if it's valid
    if vim.api.nvim_win_is_valid(terminal.win) then vim.api.nvim_win_close(terminal.win, true) end

    -- Check if the job has exited and clean up if so
    if vim.api.nvim_buf_is_valid(terminal.buf) then
        local job_status = vim.fn.jobwait({ terminal.job_id }, 0)[1]

        -- If job has exited, kill the terminal completely
        if job_status ~= -1 then kill(name) end
    end
end

-- Create a new floating terminal
local function create_terminal(name, cmd)
    local buf = vim.api.nvim_create_buf(false, true)
    local win_config = get_float_dimensions()
    local win = vim.api.nvim_open_win(buf, true, win_config)

    vim.bo[buf].bufhidden = 'hide'
    vim.bo[buf].filetype = 'terminal'

    local term_cmd = cmd or vim.o.shell
    local job_id = vim.fn.jobstart(term_cmd, { term = true })

    vim.keymap.set('t', '<esc><esc>', function() close(name) end, { buffer = buf, nowait = true })

    vim.api.nvim_create_autocmd('TermClose', {
        buffer = buf,
        callback = function()
            vim.schedule(function() close(name) end)
        end,
        once = true,
    })

    vim.cmd('startinsert')

    return {
        buf = buf,
        win = win,
        job_id = job_id,
        name = name,
        cmd = cmd,
    }
end

-- Toggle terminal by name
local function toggle(name, cmd)
    name = name or 'default'
    local terminal = terminals[name]

    if terminal and vim.api.nvim_win_is_valid(terminal.win) then
        close(name)
        return
    end

    if terminal and vim.api.nvim_buf_is_valid(terminal.buf) then
        -- Check if the job is still running
        local job_status = vim.fn.jobwait({ terminal.job_id }, 0)[1]

        -- If job has exited (status != -1), kill the terminal and create a new one
        if job_status ~= -1 then
            kill(name)
            terminal = create_terminal(name, cmd)
            terminals[name] = terminal
            last_terminal = name
            return
        end

        -- Job is still running, just reopen the window
        local win_config = get_float_dimensions()
        terminal.win = vim.api.nvim_open_win(terminal.buf, true, win_config)
        vim.cmd('startinsert')
        last_terminal = name
        return
    end

    terminal = create_terminal(name, cmd)
    terminals[name] = terminal
    last_terminal = name
end

-- Create user commands
vim.api.nvim_create_user_command('TermFloat', function(args)
    local name = args.args ~= '' and args.args or nil
    toggle(name)
end, { nargs = '?' })

vim.api.nvim_create_user_command('TermFloatKill', function(args)
    -- If argument provided, kill that specific terminal
    if args.args ~= '' then
        kill(args.args)
        return
    end

    local terminal_names = {}
    for name, _ in pairs(terminals) do
        table.insert(terminal_names, name)
    end
    table.sort(terminal_names)

    if #terminal_names == 0 then
        vim.notify('No floating terminals open', vim.log.levels.INFO)
        return
    end

    vim.ui.select(terminal_names, {
        prompt = 'Select floating terminal to kill:',
        format_item = function(name)
            local term = terminals[name]
            local status = '●'
            local job_status = vim.fn.jobwait({ term.job_id }, 0)[1]
            if job_status ~= -1 then status = '○' end
            local visible = vim.api.nvim_win_is_valid(term.win) and ' [open]' or ''
            return status .. ' ' .. name .. visible
        end,
    }, function(choice)
        if choice then
            kill(choice)
            vim.notify('Killed terminal: ' .. choice, vim.log.levels.INFO)
        end
    end)
end, { nargs = '?' })

vim.api.nvim_create_user_command('TermFloatKillAll', function()
    local count = 0
    for _, _ in pairs(terminals) do
        count = count + 1
    end

    if count == 0 then
        vim.notify('No floating terminals open', vim.log.levels.INFO)
        return
    end

    local confirm = vim.fn.confirm('Kill ' .. count .. ' floating terminal(s)?', '&Yes\n&No', 2)
    if confirm == 1 then
        for name, _ in pairs(terminals) do
            kill(name)
        end
        vim.notify('All terminals killed', vim.log.levels.INFO)
    end
end, {})

vim.api.nvim_create_user_command('TermFloatOpen', function()
    local terminal_names = {}
    for name, _ in pairs(terminals) do
        table.insert(terminal_names, name)
    end
    table.sort(terminal_names)

    if #terminal_names == 0 then
        vim.notify('No floating terminals open', vim.log.levels.INFO)
        return
    end

    vim.ui.select(terminal_names, {
        prompt = 'Select floating terminal to open:',
        format_item = function(name)
            local term = terminals[name]
            local status = '●'
            local job_status = vim.fn.jobwait({ term.job_id }, 0)[1]
            if job_status ~= -1 then
                status = '○' -- exited
            end
            local visible = vim.api.nvim_win_is_valid(term.win) and ' [open]' or ''
            return status .. ' ' .. name .. visible
        end,
    }, function(choice)
        if choice then toggle(choice, terminals[choice].cmd) end
    end)
end, {})

-- Predefined TUI commands
vim.api.nvim_create_user_command('LazyGit', function() toggle('lazygit', 'lazygit') end, {})
