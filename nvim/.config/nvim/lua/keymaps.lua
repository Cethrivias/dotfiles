-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>q', '<cmd>Telescope diagnostics<cr>', { desc = 'Open diagnostics list' })

vim.keymap.set('v', 'J', ":m '>+1<cr>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<cr>gv=gv", { desc = 'Move selection down' })

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste without overriding current register' })

-- tabs
vim.keymap.set('n', '<leader>tn', ':tabnew<cr>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tq', ':tabclose<cr>', { desc = 'Close tab' })
vim.keymap.set('n', '<leader>th', ':tabn<cr>', { desc = 'Previous tab' })
vim.keymap.set('n', '<leader>tl', ':tabp<cr>', { desc = 'Next tab' })
