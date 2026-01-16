-- Clear search highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<cr>', { silent = true })

-- Center screen when jumping
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result (centered)', noremap = true })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result (centered)', noremap = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page down (centered)' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page up (centered)' })

-- Better J behavior
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines and keep cursor position', noremap = true })

-- Better indenting
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right', noremap = true })
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left', noremap = true })

-- Split window
vim.keymap.set('n', '<C-w>-', '<cmd>split<cr>', { desc = 'Split window', silent = true })
vim.keymap.set('n', '<C-w>_', '<cmd>vsplit<cr>', { desc = 'Split window vertically', silent = true })

-- Navigate splits
vim.keymap.set({ 'n', 't' }, '<C-h>', '<cmd>wincmd h<cr>', { desc = 'Navigate left', silent = true })
vim.keymap.set({ 'n', 't' }, '<C-l>', '<cmd>wincmd l<cr>', { desc = 'Navigate right', silent = true })
vim.keymap.set({ 'n', 't' }, '<C-j>', '<cmd>wincmd j<cr>', { desc = 'Navigate down', silent = true })
vim.keymap.set({ 'n', 't' }, '<C-k>', '<cmd>wincmd k<cr>', { desc = 'Navigate up', silent = true })

-- Resize splits
vim.keymap.set({ 'n', 't' }, '<C-left>', '<cmd>vertical resize -5<cr>', { desc = 'Width [-]', silent = true })
vim.keymap.set({ 'n', 't' }, '<C-right>', '<cmd>vertical resize +5<cr>', { desc = 'Width [+]', silent = true })
vim.keymap.set({ 'n', 't' }, '<C-down>', '<cmd>resize +5<cr>', { desc = 'Height [+]', silent = true })
vim.keymap.set({ 'n', 't' }, '<C-up>', '<cmd>resize -5<cr>', { desc = 'Height [-]', silent = true })

-- Swap splits
vim.keymap.set('n', '<C-S-left>', '<C-w>H', { desc = 'Swap left', silent = true })
vim.keymap.set('n', '<C-S-right>', '<C-w>L', { desc = 'Swap right', silent = true })
vim.keymap.set('n', '<C-S-down>', '<C-w>J', { desc = 'Swap bottom', silent = true })
vim.keymap.set('n', '<C-S-up>', '<C-w>K', { desc = 'Swap top', silent = true })

-- Manager config/plugins/packages
vim.keymap.set('n', '<leader>x', '<cmd>edit ~/.config/nvim/init.lua<cr>', { desc = 'Edit config', silent = true })
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Open lazy', silent = true })

-- Toggle
vim.keymap.set('n', '<leader>tf', '<cmd>ToggleAutoFormatting<cr>', { desc = 'Auto formatting', silent = true })
vim.keymap.set('n', '<leader>th', '<cmd>ToggleLspInlayHints<cr>', { desc = 'LSP inlay hints', silent = true })
vim.keymap.set(
    'n',
    '<leader>tl',
    '<cmd>ToggleRelativeLineNumbers<cr>',
    { desc = 'Relative line numbers', silent = true }
)
vim.keymap.set('n', '<leader>ts', '<cmd>ToggleSpellCheck<cr>', { desc = 'Spell check', silent = true })
vim.keymap.set('n', '<leader>tv', '<cmd>ToggleLspVirtualLines<cr>', { desc = 'LSP virtual lines', silent = true })
vim.keymap.set('n', '<leader>tw', '<cmd>ToggleWordWrap<cr>', { desc = 'Word wrap', silent = true })
