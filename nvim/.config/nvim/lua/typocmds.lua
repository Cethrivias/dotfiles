vim.api.nvim_create_user_command('Wqa', function()
    vim.cmd 'wqa'
end, { desc = 'Format current buffer with LSP' })

vim.api.nvim_create_user_command('WQa', function()
    vim.cmd 'wqa'
end, { desc = 'Format current buffer with LSP' })

vim.api.nvim_create_user_command('WA', function()
    vim.cmd 'wa'
end, { desc = 'Format current buffer with LSP' })

vim.api.nvim_create_user_command('Wa', function()
    vim.cmd 'wa'
end, { desc = 'Format current buffer with LSP' })

vim.api.nvim_create_user_command('W', function()
    vim.cmd 'w'
end, { desc = 'Format current buffer with LSP' })
