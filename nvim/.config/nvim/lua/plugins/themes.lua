return {
    {
        'projekt0n/github-nvim-theme',
        name = 'github-theme',
        opts = {}
    },
    -- {
    --     'navarasu/onedark.nvim',
    --     opts = { style = 'darker' },
    -- },
    -- {
    --     'folke/tokyonight.nvim',
    --     opts = {},
    -- },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        config = function()
            require('catppuccin').setup {
                transparent = true,
                highlight_overrides = {
                    all = function(colors)
                        return {
                            Visual = { bg = colors.surface0 },
                        }
                    end,
                },
            }

            -- vim.cmd.colorscheme 'catppuccin'
        end,
    },
}
