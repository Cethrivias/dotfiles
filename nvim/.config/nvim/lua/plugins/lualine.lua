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
                    'filetype', --[[ 'fileformat', ]]
                    'encoding',
                },
                lualine_y = { --[[ 'progress' ]]
                },
            },
        }
    end,
}
