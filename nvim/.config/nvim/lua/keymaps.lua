-- [[ removing default lsp keymaps ]]
vim.keymap.del('n', 'gra')
vim.keymap.del('n', 'grr')
vim.keymap.del('n', 'gri')
vim.keymap.del('n', 'gO')
vim.keymap.del('n', 'grn')

-- keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('v', 'J', ":m '>+1<cr>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<cr>gv=gv", { desc = 'Move selection down' })

-- center on jumps
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste without overriding current register' })

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { desc = 'Clear highlights' })

-- tabs
vim.keymap.set('n', '<leader>tn', ':tabnew<cr>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tq', ':tabclose<cr>', { desc = 'Close tab' })
vim.keymap.set('n', '<leader>th', ':tabn<cr>', { desc = 'Previous tab' })
vim.keymap.set('n', '<leader>tl', ':tabp<cr>', { desc = 'Next tab' })

-- weird debugging magic
vim.keymap.set('n', '<leader><leader>x', '<cmd>source %<CR>', { desc = 'Source current file' })
vim.keymap.set('n', '<leader>x', ':.lua<CR>', { desc = 'Source current line' })
vim.keymap.set('v', '<leader>x', ':lua<CR>', { desc = 'Source current line' })

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')
