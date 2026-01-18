return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'windwp/nvim-ts-autotag' },
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
        ensure_installed = {
            'c',
            'c_sharp',
            'lua',
            'vim',
            'vimdoc',
            'regex',
            'lua',
            'bash',
            'markdown',
            'markdown_inline',
            'javascript',
            'typescript',
            'angular',
            'kdl',
            'xml',
            'yaml',
            'dockerfile',
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
    },
    init = function()
        require('vim.treesitter.query').add_predicate('is-mise?', function(_, _, bufnr, _)
            local filepath = vim.api.nvim_buf_get_name(tonumber(bufnr) or 0)
            local filename = vim.fn.fnamemodify(filepath, ':t')
            return string.match(filename, '.*mise.*%.toml$') ~= nil
        end, { force = true, all = false })
    end,
}
