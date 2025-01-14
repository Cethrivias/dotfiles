vim.keymap.set('t', '<leader><esc>', '<c-\\><c-n>')

return {
    {
        --[[ dir = '~/Projects/personal/barely-afloat.nvim', ]]
        'Cethrivias/barely-afloat.nvim',
        branch = 'master',
        config = function()
            local barely_afloat = require 'barely-afloat';
            barely_afloat.command('Htop', 'htop')
            barely_afloat.command('Lg', 'lazygit')
            barely_afloat.command('Zsh', 'zsh')
        end,
    },
}
