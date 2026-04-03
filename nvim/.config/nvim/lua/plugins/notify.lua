return {
    'rcarriga/nvim-notify',
    config = function()
        local notify = require('notify')
        notify.setup {
            merge_duplicates = false,
            render = "wrapped-compact",
            stages = "fade",
            background_colour = "#1E1E2E",
        }
        vim.notify = notify
    end
}
