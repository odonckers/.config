return {
    'lewis6991/gitsigns.nvim',
    enabled = false,
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
    keys = {
        { '<leader>gp', '<cmd>Gitsigns preview_hunk<cr>', desc = 'Preview hunk', silent = true },
        { '<leader>gr', '<cmd>Gitsigns reset_hunk<cr>', desc = 'Reset hunk', silent = true },
        { '<leader>gs', '<cmd>Gitsigns stage_hunk<cr>', desc = 'Stage hunk', silent = true },
        { '<leader>tg', '<cmd>Gitsigns toggle_current_line_blame<cr>', desc = 'Git line blame', silent = true },
    },
}
