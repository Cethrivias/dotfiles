vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- nvim tree requirements
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
local listchars = {
    'eol: ', -- end of line (↴)
    'tab:‣ ,leadtab:‣ ', -- tabs (‣ - triangular bullet, ∘ - math ring operator, ▹ - white right-pointing small triangle)
    'multispace:∙,leadmultispace: ,trail:·', -- spaces (· - math bullet operator)
    'nbsp:‿,extends:>,precedes:<' -- special (‿ - undertie)
}
vim.opt.listchars = table.concat(listchars, ',')
vim.opt.list = true
vim.o.breakindent = true

-- spellcheck
vim.opt.spell = true
vim.opt.spelloptions = 'camel'
vim.opt.spellcapcheck = ''

-- set highlight on search
vim.o.hlsearch = true

-- editor
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '120'
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'line'
vim.opt.wrap = false
vim.o.winborder = 'rounded'
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 5
vim.opt.foldenable = true -- fold everything above foldlevel by default

-- split
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sync clipboard between OS and Neovim.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.confirm = true
