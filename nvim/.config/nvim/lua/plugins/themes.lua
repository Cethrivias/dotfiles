return {
    {
        'projekt0n/github-nvim-theme',
        name = 'github-theme',
        opts = {},
    },
    {
        'navarasu/onedark.nvim',
        opts = { style = 'warmer' }, -- dark, darker, cool, deep, warm, warmer
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
            styles = {
                -- "dark", "transparent" or "normal"
                sidebars = "transparent", -- style for sidebars, see below
                floats = "dark", -- style for floating windows
            },
        },
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        opts = {
            transparent_background = true,
            background = { -- :h background
                light = "latte",
                dark = "mocha",
            },
            -- highlight_overrides = {
            --     all = function(colors)
            --         return {
            --             Visual = { bg = colors.surface0 },
            --         }
            --     end,
            -- },
        }
    },
    {
        'shaunsingh/nord.nvim'
    },
    {
        'morhetz/gruvbox'
    }
}
