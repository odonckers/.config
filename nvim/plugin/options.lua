-- Custom settings
vim.g.indentline_char = '│'
vim.g.lead_char = '·'
vim.g.relativenumber = false

-- Basic settings
vim.opt.number = true -- Line numbers
vim.opt.relativenumber = vim.g.relativenumber -- Relative line numbers
vim.opt.cursorline = true -- Highlight current line
vim.opt.wrap = false -- Don't wrap lines
vim.opt.scrolloff = 10 -- Keep 10 lines above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor

-- Indentation
vim.opt.tabstop = 2 -- Tab width
vim.opt.shiftwidth = 2 -- Indent width
vim.opt.softtabstop = 2 -- Soft tab stop
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.autoindent = true -- Copy indent from current line

-- Search settings
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Case sensitive if uppercase in search
vim.opt.hlsearch = true -- Highlight search results
vim.opt.incsearch = true -- Show matches as you type

-- Visual settings
vim.opt.termguicolors = true -- Enable 24-bit colors
vim.opt.signcolumn = 'yes' -- Always show sign column
vim.opt.colorcolumn = '120' -- Show column at 120 characters
vim.opt.showmatch = true -- Highlight matching brackets
vim.opt.matchtime = 2 -- How long to show matching bracket
vim.opt.cmdheight = 1 -- Command line height
vim.opt.completeopt = 'menuone,noinsert,noselect' -- Completion options
vim.opt.showmode = false -- Don't show mode in command line
vim.opt.pumheight = 10 -- Popup menu height
vim.opt.pumblend = 0 -- Popup menu transparency
vim.opt.winblend = 0 -- Floating window transparency
vim.o.winborder = 'rounded' -- Floating window border
vim.opt.conceallevel = 0 -- Don't hide markup
vim.opt.concealcursor = '' -- Don't hide cursor line markup
vim.opt.lazyredraw = false -- Don't redraw during macros
vim.opt.synmaxcol = 300 -- Syntax highlighting limit
vim.opt.list = true -- Display whitespace characters
vim.opt.listchars = { -- Whitespace characters definitions
    tab = '» ',
    trail = '·',
    nbsp = '␣',
    lead = vim.g.lead_char,
}
vim.opt.fillchars = { eob = ' ' } -- Fill characters
vim.opt.breakindent = true -- Wrapped lines will indent visually
vim.opt.linebreak = true -- Wrapped lines will soft break on whitespace
vim.opt.laststatus = 2 -- Status line appears on every pane

-- File handling
vim.opt.backup = false -- Don't create backup files
vim.opt.writebackup = false -- Don't create backup before writing
vim.opt.swapfile = false -- Don't create swap files
vim.opt.undofile = true -- Persistent undo
vim.opt.undodir = vim.fn.expand('~/.vim/undodir') -- Undo directory
vim.opt.updatetime = 300 -- Faster completion
vim.opt.timeoutlen = 500 -- Key timeout duration
vim.opt.ttimeoutlen = 0 -- Key code timeout
vim.opt.autoread = true -- Auto reload files changed outside vim
vim.opt.autowrite = false -- Don't auto save
vim.opt.fileformats = { 'unix', 'dos', 'mac' } -- Match eof formatting to system

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand('~/.vim/undodir')
if vim.fn.isdirectory(undodir) == 0 then vim.fn.mkdir(undodir, 'p') end

-- LSP and diagnostic visuals
vim.diagnostic.config({
    float = {
        border = 'rounded',
        focusable = true,
    },
    virtual_lines = { current_line = true },
    virtual_text = false,
    underline = { severity = vim.diagnostic.severity.WARN },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.HINT] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
        },
        texthl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
            [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.HINT] = '',
            [vim.diagnostic.severity.INFO] = '',
        },
    },
})

-- Behavior settings
vim.opt.hidden = true -- Allow hidden buffers
vim.opt.errorbells = false -- No error bells
vim.opt.backspace = 'indent,eol,start' -- Better backspace behavior
vim.opt.autochdir = false -- Don't auto change directory
vim.opt.iskeyword:append('-') -- Treat dash as part of word
vim.opt.path:append('**') -- include subdirectories in search
vim.opt.selection = 'inclusive' -- Selection behavior (visual mode)
vim.opt.mouse = 'a' -- Enable mouse support
vim.schedule(function()
    vim.opt.clipboard:append('unnamedplus') -- Use system clipboard
end)
vim.opt.modifiable = true -- Allow buffer modifications
vim.opt.encoding = 'UTF-8' -- Set encoding
vim.opt.inccommand = 'split' -- Preview substitutions
vim.opt.confirm = true -- Confirm dialog for unsaved changes
vim.opt.fixeol = true -- Remove eol character
vim.opt.fixendofline = false -- Fix end of line
vim.opt.history = 100 -- Remember N lines in history
vim.cmd('syntax sync minlines=256') -- Limit syntax parsing to N amount of lines
vim.opt.spell = false -- Set spell check globally for all file types

-- Folding settings
vim.opt.foldmethod = 'expr' -- Use expression for folding
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()' -- Use treesitter for folding
vim.opt.foldlevel = 99 -- Start with all folds open

-- Split behavior
vim.opt.splitbelow = true -- Horizontal splits go below
vim.opt.splitright = true -- Vertical splits go right

-- Command-line completion
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'
vim.opt.wildignore:append({ '*.o', '*.obj', '*.pyc', '*.class', '*.jar' })

-- Better diff options
vim.opt.diffopt:append('linematch:60')

-- Performance improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000
