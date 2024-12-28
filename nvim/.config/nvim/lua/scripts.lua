local augroup_id = nil

local toggle_formatting_characters = function()
    if augroup_id then
        vim.api.nvim_del_augroup_by_id(augroup_id)
        augroup_id = nil
        return
    end

    augroup_id = vim.api.nvim_create_augroup('formatting_characters_augroup', { clear = true })
    vim.api.nvim_create_autocmd('ModeChanged', {
        group = augroup_id,
        pattern = '[vV\x16]*:*',
        command = 'lua vim.opt.list=false',
        desc = 'Disable list when exiting visual mode',
    })

    vim.api.nvim_create_autocmd('ModeChanged', {
        group = augroup_id,
        pattern = '*:[vV\x16]*',
        command = 'lua vim.opt.list=true',
        desc = 'Enable list when entering visual mode',
    })
end

vim.api.nvim_create_user_command(
    'ToggleFormattingCharacters',
    toggle_formatting_characters,
    { desc = 'Toggle formatting characters visibility' }
)
