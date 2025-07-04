require 'options'

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out,                            'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup 'plugins'

require 'scripts'
require 'keymaps'
require 'startup'
require 'typocmds'

vim.cmd.colorscheme 'catppuccin-mocha'
-- vim.cmd.colorscheme 'catppuccin-latte'
--[[
vim.cmd.colorscheme 'tokyonight'
vim.cmd.colorscheme 'tokyonight-night'
vim.cmd.colorscheme 'onedark'
vim.cmd.colorscheme 'github_dark_default'
vim.cmd.colorscheme 'github_light'
--]]

vim.g.zig_fmt_autosave = 0
