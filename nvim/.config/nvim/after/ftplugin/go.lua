local const_ls = require('const').listchars

local ls = vim.deepcopy(const_ls)

ls.leadtab = '┆ '; -- '› ';

vim.opt_local.listchars = ls;
vim.opt_local.list = true;
vim.notify("set custom listchars", vim.log.levels.INFO)
