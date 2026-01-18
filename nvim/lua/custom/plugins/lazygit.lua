-- TODO: Replace this with custom ":term" window
return {
    'kdheepak/lazygit.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = {
        'LazyGit',
        'LazyGitConfig',
        'LazyGitCurrentFile',
        'LazyGitFilter',
        'LazyGitFilterCurrentFile',
    },
    keys = {
        { '<leader>gl', '<cmd>LazyGit<cr>', desc = 'LazyGit', silent = true },
    },
}
