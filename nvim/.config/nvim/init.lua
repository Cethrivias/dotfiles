require 'options'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup 'plugins'

require 'scripts'
require 'keymaps'

vim.cmd.colorscheme 'catppuccin'
-- vim.cmd.colorscheme 'tokyonight-night'
-- vim.cmd.colorscheme 'onedark darker'
-- vim.cmd.colorscheme 'github_dark_default'
-- vim.cmd.colorscheme 'github_light'
