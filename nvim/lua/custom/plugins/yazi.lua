---@module "lazy"
---@type LazySpec
return {
    'mikavilpas/yazi.nvim',
    version = '*', -- use the latest stable version
    event = 'VeryLazy',
    dependencies = {
        { 'nvim-lua/plenary.nvim', lazy = true },
    },
    ---@module "yazi"
    ---@type YaziConfig | {}
    opts = {
        open_for_directories = false,
        keymaps = {
            show_help = '<f1>',
        },
    },
    keys = {
        {
            '<leader><space>',
            mode = { 'n', 'v' },
            '<cmd>Yazi<cr>',
            desc = 'Open yazi at the current file',
        },
        {
            '<leader>y',
            '<cmd>Yazi cwd<cr>',
            desc = "Open the file manager in nvim's working directory",
        },
    },
}
