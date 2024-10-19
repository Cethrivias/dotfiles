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
        require('neo-tree').setup()

        vim.keymap.set('n', '<leader>1', '<cmd>Neotree toggle reveal<cr>', { desc = 'Show file tree' })
        vim.keymap.set('n', '<leader>2', '<cmd>Neotree current reveal<cr>', { desc = 'Show file tree in a current window' })
        vim.keymap.set('n', '<leader>3', '<cmd>Neotree current buffers reveal<cr>', { desc = 'Show file tree' })
    end,
}

-- return {
--     'nvim-tree/nvim-tree.lua',
--     version = '*',
--     lazy = false,
--     dependencies = { 'nvim-tree/nvim-web-devicons' },
--     config = function()
--         require('nvim-tree').setup {
--             diagnostics = {
--                 enable = true,
--                 show_on_dirs = true,
--             },
--         }
--         vim.keymap.set('n', '<leader>1', '<cmd>NvimTreeToggle<cr>', {})
--         vim.keymap.set('n', '<leader>!', '<cmd>NvimTreeFindFile<cr>', {})
--         vim.cmd('NvimTreeToggle')
--     end,
-- }
