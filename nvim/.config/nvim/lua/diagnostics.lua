-- vim.diagnostic.config({ virtual_text = true })
vim.diagnostic.config({
    -- virtual_text = true,
    -- virtual_lines = { current_line = true },
    virtual_text = { current_line = true },
    underline = true,
    signs = {
        active = true,
        text = {
            [vim.diagnostic.severity.ERROR] = "⊗",
            [vim.diagnostic.severity.WARN]  = "⚠",
            [vim.diagnostic.severity.HINT]  = "",
            [vim.diagnostic.severity.INFO]  = "",
        },
    },
})
local asd
-- vim.diagnostic.config({ virtual_lines = { current_line = true } })

-- Diagnostic keymaps
local function go_to_diag(direction)
    return function()
        vim.diagnostic.jump { count = direction, float = true }
    end
end

vim.keymap.set('n', '[d', go_to_diag(1), { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', go_to_diag(-1), { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>q', '<cmd>Telescope diagnostics<cr>', { desc = 'Open diagnostics list' })
