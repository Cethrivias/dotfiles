vim.keymap.set(
    'n',
    '<leader>2',
    '<cmd>Oil<cr>',
    { desc = 'Show file tree in a current window' }
)
return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        keymaps = {
            ["<C-r>"] = { "actions.refresh", mode = "n" },
            ["<BS>"] = { "actions.parent", mode = "n" },
            ["<C-p>"] = false
        },
        view_options = {
            show_hidden = true
        }
    },
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
}
