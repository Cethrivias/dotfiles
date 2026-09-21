vim.api.nvim_create_user_command('Lg', function()
    require('snacks').lazygit.open();
end, { desc = 'Open lazygit' })

return {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
        scroll = {},
        lazygit = {},
        notifier = {}
    }
}
