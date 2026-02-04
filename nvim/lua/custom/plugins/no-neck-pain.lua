return {
    'shortcuts/no-neck-pain.nvim',
    version = '*',
    opts = {
        width = 'colorcolumn',
        autocmds = { enableOnVimEnter = true },
        mappings = { enabled = true },
        buffers = {
            right = { enabled = false },
        },
    },
}
