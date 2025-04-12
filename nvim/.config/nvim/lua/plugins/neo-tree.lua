return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
        'MunifTanjim/nui.nvim',
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
        require('neo-tree').setup {
            window = {
                mappings = {
                    ["b"] = "noop"
                }
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
                follow_current_file = {
                    enabled = true,          -- This will find and focus the file in the active buffer every time
                    --              -- the current file is changed while the tree is open.
                    leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                },
            },
        }

        vim.keymap.set('n', '<leader>1', '<cmd>Neotree toggle reveal<cr>', { desc = 'Show file tree' })
        vim.keymap.set(
            'n',
            '<leader>2',
            '<cmd>Neotree current reveal<cr>',
            { desc = 'Show file tree in a current window' }
        )
        vim.keymap.set('n', '<leader>3', '<cmd>Neotree current buffers reveal<cr>', { desc = 'Show file tree' })
    end,
}
