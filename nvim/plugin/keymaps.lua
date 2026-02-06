-- Clear search highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<cr>', { silent = true })

-- Center screen when jumping
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result (centered)', noremap = true })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result (centered)', noremap = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page down (centered)' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page up (centered)' })

-- Better J behavior
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines and keep cursor position', noremap = true })

-- Bordered hover
vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({ border = 'rounded' }) end, { desc = 'Hover' })

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

-- Buffers
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Close buffer', silent = true })

-- Quickfix list
vim.keymap.set('n', '<leader>co', '<cmd>copen<cr>', { desc = 'Open', silent = true })
vim.keymap.set('n', '<leader>cc', '<cmd>cclose<cr>', { desc = 'Close', silent = true })
vim.keymap.set('n', '<leader>cr', '<cmd>cexpr []<bar>cclose<cr>', { desc = 'Reset', silent = true })

-- Diagnostics
vim.keymap.set('n', '<leader>dq', function() vim.diagnostic.setqflist() end, { desc = 'Set quickfix list' })

-- Sessions
vim.keymap.set('n', '<leader>sm', '<cmd>mksession!<cr>', { desc = 'Make session' })
vim.keymap.set('n', '<leader>ss', '<cmd>source Session.vim<cr>', { desc = 'Source session in cwd' })
