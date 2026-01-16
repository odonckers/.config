return {
    'saghen/blink.cmp',
    dependencies = {
        'rafamadriz/friendly-snippets',
        'ribru17/blink-cmp-spell',
    },
    version = '1.*',
    opts = {
        keymap = {
            preset = 'enter',
            ['<Tab>'] = {
                'snippet_forward',
                function() return require('sidekick').nes_jump_or_apply() end,
                'fallback',
            },
        },
        completion = {
            list = {
                selection = { preselect = false },
            },
            menu = { border = 'single' },
            documentation = {
                window = { border = 'single' },
            },
        },
        signature = {
            window = { border = 'single' },
        },
        sources = {
            default = {
                'lsp',
                'path',
                'snippets',
                'buffer',
                'spell',
            },
            providers = {
                spell = {
                    name = 'Spell',
                    module = 'blink-cmp-spell',
                },
            },
        },
        fuzzy = {
            sorts = {
                function(a, b)
                    local sort = require('blink.cmp.fuzzy.sort')
                    if a.source_id == 'spell' and b.source_id == 'spell' then return sort.label(a, b) end
                end,
                -- This is the normal default order, which we fall back to
                'score',
                'kind',
                'label',
            },
        },
    },
}
