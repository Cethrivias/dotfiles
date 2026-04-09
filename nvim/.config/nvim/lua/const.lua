local M = {};

M.listchars = {
    eol = ' ', -- end of line (↴)
    tab = '‣ ', -- tabs (‣ - triangular bullet, ∘ - math ring operator, ▹ - white right-pointing small triangle)
    leadtab = '‣ ',
    multispace = '∙', -- spaces (· - math bullet operator)
    leadmultispace = ' ',
    trail = '·',
    nbsp = '‿', -- special (‿ - undertie)
    extends = '…',
    precedes = '…'
};

return M;
