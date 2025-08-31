return {
    {
        'nvim-telescope/telescope.nvim',
        -- branch = '0.1.x',
        branch = 'master',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- NOTE: If you are having trouble with this installation,
                --       refer to the README for telescope-fzf-native for more instructions.
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
        config = function()
            require('telescope').setup {
                defaults = {
                    layout_strategy = 'vertical',
                    file_ignore_patterns = { '^.git/' },
                },
                pickers = {
                    find_files = {
                        -- theme = 'dropdown',
                        hidden = true,
                    },
                    live_grep = {
                        -- theme = 'dropdown',
                    },
                },
            }

            local builtin = require 'telescope.builtin'
            local custom = require("custom.telescope")
            vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
            vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Search Files' })
            vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch [B]uffers' })
            vim.keymap.set('n', '<leader>4', builtin.buffers, { desc = 'Search Buffers' })
            vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
            -- vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sg', custom.multi_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
            vim.keymap.set('n', '<leader>/', function()
                -- You can pass additional configuration to telescope to change theme, layout, etc.
                -- builtin.get_dropdown {
                --     winblend = 10,
                --     previewer = false,
                -- })
                builtin.current_buffer_fuzzy_find()
            end, { desc = '[/] Fuzzily search in current buffer' })

            -- Enable telescope fzf native, if installed
            pcall(builtin.load_extension, 'fzf')
        end,
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            require('telescope').setup {
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown {
                            -- even more opts
                        },
                    },
                },
            }
            require('telescope').load_extension 'ui-select'
        end,
    },
}
