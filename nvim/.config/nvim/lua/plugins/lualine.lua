return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup {
            options = {
                disabled_filetypes = { 'NvimTree', 'neo-tree' },
            },
            sections = {
                lualine_x = {
                    -- 'lsp_status', does not work with gitlab lsp enabled
                    {
                        function()
                            local state = require 'gitlab.statusline'.state
                            if state == '' or state == nil then
                                return ''
                            end
                            return state
                        end,
                        icon = { '', align = 'left', color = { fg = '#E24329' } },
                    },
                    'filetype', --[[ 'fileformat', ]]
                    'encoding',
                },
                lualine_y = { --[[ 'progress' ]]
                },
            },
        }
    end,
}
