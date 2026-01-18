return {
    'ibhagwan/fzf-lua',
    lazy = false,
    opts = {
        winopts = {
            preview = {
                flip_columns = 168, -- 4 (decorations) + 164
            },
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
        keymap = {
            fzf = {
                true,
                ['ctrl-q'] = 'select-all+accept',
            },
        },
    },
    keys = {
        { '<leader><leader>', '<cmd>FzfLua files<cr>', desc = 'Search files names', silent = true },
        { '<leader>/', '<cmd>FzfLua live_grep<cr>', desc = 'Search file contents', silent = true },
        {
            '<leader>?',
            '<cmd>FzfLua grep_cword<cr>',
            desc = 'Search file contents for word under cursor',
            silent = true,
        },
        { '<leader>`', '<cmd>FzfLua marks<cr>', desc = 'Search marks', silent = true },
        {
            '<leader>b',
            -- height = 4 (decorations) + 1 (separator) + 40 (buffers)
            -- width = 4 (decorations) + 100
            '<cmd>FzfLua buffers winopts={height=45,width=104,preview={hidden=true}}<cr>',
            desc = 'Search open buffers',
            silent = true,
        },
        { '<leader>e', '<cmd>FzfLua oldfiles<cr>', desc = 'Search old files', silent = true },
        { '<leader>r', '<cmd>FzfLua resume<cr>', desc = 'Resume last open FZF', silent = true },
    },
}
