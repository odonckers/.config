---@module "lazy"
---@type LazySpec
return {
    'nvim-neo-tree/neo-tree.nvim',
    lazy = false, -- neo-tree will lazily load itself
    branch = 'v3.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
        'nvim-mini/mini.icons',
    },
    ---@module "neo-tree"
    ---@type neotree.Config
    opts = {
        close_if_last_window = true,
        popup_border_style = '',
        clipboard = {
            sync = 'universal',
        },
        default_component_configs = {
            indent = {
                indent_size = 2,
                padding = 0, -- extra padding on left hand side
                -- indent guides
                with_markers = true,
                indent_marker = '│',
                last_indent_marker = '└',
                highlight = 'NeoTreeIndentMarker',
                -- expander config, needed for nesting files
                with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                expander_collapsed = '',
                expander_expanded = '',
                expander_highlight = 'NeoTreeExpander',
            },
            icon = {
                folder_closed = '',
                folder_open = '',
                folder_empty = '󰜌',
                -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                -- then these will never be used.
                default = '*',
                highlight = 'NeoTreeFileIcon',
                use_filtered_colors = true, -- Whether to use a different highlight when the file is filtered (hidden, dotfile, etc.).
            },
            modified = {
                symbol = '[+]',
                highlight = 'NeoTreeModified',
            },
            name = {
                trailing_slash = false,
                use_filtered_colors = true, -- Whether to use a different highlight when the file is filtered (hidden, dotfile, etc.).
                use_git_status_colors = true,
                highlight = 'NeoTreeFileName',
            },
            git_status = {
                symbols = {
                    -- Change type
                    added = '', -- or "✚"
                    modified = '', -- or ""
                    deleted = '✖', -- this can only be used in the git_status source
                    renamed = '󰁕', -- this can only be used in the git_status source
                    -- Status type
                    untracked = '',
                    ignored = '',
                    unstaged = '󰄱',
                    staged = '',
                    conflict = '',
                },
            },
            file_size = { enabled = true, width = 12, required_width = 88 },
            last_modified = { enabled = true, width = 20, required_width = 100 },
            type = { enabled = true, width = 10, required_width = 120 },
            created = { enabled = true, width = 20, required_width = 140 },
            symlink_target = { enabled = true },
        },
        filesystem = {
            filtered_items = { visible = true },
            follow_current_file = {
                enabled = true,
                leave_dirs_open = false,
            },
        },
    },
    keys = {
        { '<leader>e', '<cmd>Neotree<cr>', desc = 'File explorer' },
    },
}
