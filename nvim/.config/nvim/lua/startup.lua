vim.api.nvim_create_autocmd('VimEnter', {
    callback = function(args)
        if args.file ~= '' then
            return
        end

        vim.cmd 'Neotree current'
        vim.opt_local.spell = false
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.colorcolumn = ''
    end,
})
