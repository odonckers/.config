---@module "lazy"
---@type LazySpec
return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-mini/mini.icons' },
    cmd = 'FzfLua',
    ---@module "fzf-lua"
    ---@type fzf-lua.Config
    opts = {
        -- utilizes fzf's native previewing ability in the terminal where possible
        -- using bat for previews and disables icons globally for max performance
        'max-perf',
        winopts = {
            height = 0.85, -- default window height
            width = 0.40, -- half default window width
            preview = { layout = 'vertical' },
        },
        previewers = {
            builtin = {
                syntax_limit_b = 1024 * 100, -- 100KB
            },
        },
        oldfiles = { include_current_session = true },
        grep = {
            rg_glob = true, -- enable glob parsing
            glob_flag = '--iglob', -- case insensitive globs
            glob_separator = '%s%-%-', -- query separator pattern (lua): ' --'
        },
    },
    keys = {
        { '<leader><leader>', '<cmd>FzfLua files<cr>', desc = 'Search files names', silent = true },
        { '<leader>/', '<cmd>FzfLua live_grep<cr>', desc = 'Search file contents', silent = true },
        { '<leader>`', '<cmd>FzfLua marks<cr>', desc = 'Search marks', silent = true },
        { '<leader>e', '<cmd>FzfLua oldfiles<cr>', desc = 'Search old files', silent = true },
        { '<leader>r', '<cmd>FzfLua resume<cr>', desc = 'Resume last open FZF', silent = true },
        { '<leader>bb', '<cmd>FzfLua buffers<cr>', desc = 'Search open buffers', silent = true },
    },
}
