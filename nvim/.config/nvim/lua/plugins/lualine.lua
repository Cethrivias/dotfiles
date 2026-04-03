return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local theme = require("lualine.themes.catppuccin-nvim")
        for _, value in pairs(theme) do
            value.a.fg = value.a.bg
            value.a.bg = "none"
            value.b.bg = "none"
        end

        require('lualine').setup {
            options = {
                disabled_filetypes = { 'NvimTree', 'neo-tree' },
                theme = theme,
                section_separators = '|',
                component_separators = '|' -- │
            },
            sections = {
                lualine_a = {
                    { "mode", padding = { left = 1, right = 0 } }
                },
                lualine_x = {
                    'lsp_status', -- does not work with gitlab ai lsp enabled
                    -- {
                    --     function()
                    --         local state = require 'gitlab.statusline'.state
                    --         if state == '' or state == nil then
                    --             return ''
                    --         end
                    --         return state
                    --     end,
                    --     icon = { '', align = 'left', color = { fg = '#E24329' } },
                    -- },
                    'filetype', 
                    -- 'fileformat',
                    'encoding',
                },
                lualine_y = {
                    -- 'progress'
                },
            },
        }
    end,
}
