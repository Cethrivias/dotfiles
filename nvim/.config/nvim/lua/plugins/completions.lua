return {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' for mappings similar to built-in completion
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        -- See the full "keymap" documentation for information on defining your own keymap.
        cmdline = {
            keymap = {
                ['<CR>'] = {},
            },
        },
        keymap = {
            preset = 'default',

            ['<Up>'] = { 'select_prev', 'fallback' },
            ['<Down>'] = { 'select_next', 'fallback' },

            ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },

            ['<CR>'] = { 'select_and_accept', 'fallback' },
        },

        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono',
        },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            per_filetype = {
                sql = { 'snippets', 'dadbod', 'buffer' },
            },
            -- add vim-dadbod-completion to your completion providers
            providers = {
                dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
            },
        },

        signature = { enabled = true },

        completion = {
            documentation = { auto_show = true },
            ghost_text = { enabled = true },
            menu = {
                draw = {
                    columns = {
                        -- { "label",      "label_description", gap = 1 },
                        { "label" },
                        { "kind_icon",  "kind", gap = 1 },
                        { "source_name" }
                    },
                }
            }
        },
    },
    opts_extend = { 'sources.default' },
}
