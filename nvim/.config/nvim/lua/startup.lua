vim.api.nvim_create_autocmd('VimEnter', {
    callback = function(args)
        if args.file ~= '' then
            return
        end

        local state = {}

        vim.cmd 'Neotree current'

        -- state.buffer = vim.api.nvim_get_current_buf()
        -- state.number = vim.opt.number
        -- state.relativenumber = vim.opt.relativenumber
        -- state.spell = vim.opt.spell
        -- state.colorcolumn = vim.opt.colorcolumn

        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.spell = false
        vim.opt_local.colorcolumn = '0'

        vim.api.nvim_create_autocmd('BufHidden', {
            buffer = state.buffer,
            callback = function()
                -- vim.opt.number = state.number
                -- vim.opt.relativenumber = state.relativenumber
                -- vim.opt.spell = state.spell
                -- vim.opt.colorcolumn = state.colorcolumn
            end,
        })
    end,
})
