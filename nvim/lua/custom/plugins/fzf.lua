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
    config = function(_, opts)
        local fzflua = require('fzf-lua')
        fzflua.setup(opts)
        fzflua.register_ui_select()
    end,
    keys = {
        {
            'gra',
            -- height = 4 (decorations) + 1 (separator) + 10 (code actions)
            -- width = 4 (decorations) + 80
            '<cmd>FzfLua lsp_code_actions winopts={height=14,width=84,preview={hidden=true}} winopts.relative=cursor<cr>',
            desc = 'Quick fix',
            silent = true,
        },
        { 'grd', '<cmd>FzfLua lsp_definitions<cr>', desc = 'Definitions', silent = true },
        { 'grD', '<cmd>FzfLua lsp_declarations<cr>', desc = 'Declarations', silent = true },
        { 'grf', '<cmd>FzfLua lsp_finder<cr>', desc = 'Find all locations', silent = true },
        { 'gri', '<cmd>FzfLua lsp_implementations<cr>', desc = 'Implementations', silent = true },
        { 'grr', '<cmd>FzfLua lsp_references<cr>', desc = 'References', silent = true },
        { 'grt', '<cmd>FzfLua lsp_typedefs<cr>', desc = 'Type definitions', silent = true },

        {
            'z=',
            '<cmd>FzfLua spell_suggest winopts.relative=cursor<cr>',
            desc = 'Spelling suggestions',
            silent = true,
        },

        { '<leader>dd', '<cmd>FzfLua diagnostics_document<cr>', desc = 'Search in document', silent = true },
        { '<leader>dw', '<cmd>FzfLua diagnostics_workspace<cr>', desc = 'Search in workspace', silent = true },

        { '<leader><leader>', '<cmd>FzfLua files<cr>', desc = 'Files FZF', silent = true },
        { '<leader>e', '<cmd>FzfLua oldfiles<cr>', desc = 'Search old files', silent = true },
        { '<leader>j', '<cmd>FzfLua jumps<cr>', desc = 'Search jumplist', silent = true },
        { '<leader>r', '<cmd>FzfLua resume<cr>', desc = 'Resume last open FZF', silent = true },
        { '<leader>q', '<cmd>FzfLua quickfix<cr>', desc = 'Search quick fix list', silent = true },
        { '<leader>`', '<cmd>FzfLua marks<cr>', desc = 'Search marks', silent = true },
        { '<leader>@', '<cmd>FzfLua lsp_document_symbols<cr>', desc = 'Search symbols', silent = true },
        { '<leader>/', '<cmd>FzfLua live_grep<cr>', desc = 'Search file contents', silent = true },
        {
            '<leader>?',
            '<cmd>FzfLua grep_cword<cr>',
            desc = 'Search file content for word under cursor',
            silent = true,
        },
    },
}
