return {
    'rcarriga/nvim-notify',
    config = function()
        local notify = require('notify')
        notify.setup {
            merge_duplicates = false,
            render = "wrapped-compact",
            stages = "fade"
        }
        vim.notify = require('notify')
    end
}
