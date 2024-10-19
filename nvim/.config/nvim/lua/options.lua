-- Nvim Tree requirements
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- indentation
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.listchars = "eol:↴,tab:> ,nbsp:+,extends:>,precedes:<,space:·"

vim.opt.spell = true
vim.opt.spelloptions = "camel"
vim.opt.spellcapcheck = ""

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- Set highlight on search
vim.o.hlsearch = true
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- editor
vim.wo.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '120'
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'line'
vim.opt.wrap = false

-- split
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- [[ Filetypes ]]
vim.filetype.add {
    extension = {
        tf = 'terraform',
        tfvars = 'terraform',
        templ = 'templ',
    },
}
