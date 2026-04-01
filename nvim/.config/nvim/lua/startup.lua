vim.api.nvim_create_autocmd('VimEnter', {
    callback = function(args)
        if args.file ~= '' then
            return
        end

        vim.cmd 'Neotree current'
    end,
})
