local indent_blankline_augroup = vim.api.nvim_create_augroup('indent_blankline_augroup', { clear = true })
vim.api.nvim_create_autocmd('ModeChanged', {
    group = indent_blankline_augroup,
    pattern = '[vV\x16]*:*',
    command = 'lua vim.opt.list=false',
    desc = 'Disable list when exiting visual mode',
})

vim.api.nvim_create_autocmd('ModeChanged', {
    group = indent_blankline_augroup,
    pattern = '*:[vV\x16]*',
    command = 'lua vim.opt.list=true',
    desc = 'Enable list when entering visual mode',
})
