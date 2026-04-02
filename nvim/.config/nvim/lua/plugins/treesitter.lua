-- Tricks:
-- :Inspect to check what treesitter thinks about what is currently under cursor
-- :InspectTree see the matrix

local langs = {
    'bash',
    'c',
    'lua',
    'vim',
    'vimdoc',
    'query',
    'c',
    'c_sharp',
    'cpp',
    'css',
    'csv',
    'git_rebase',
    'gitcommit',
    'gitignore',
    'go',
    'javascript',
    'json',
    'html',
    'rust',
    'sql',
    'terraform',
    'toml',
    'typescript',
    'markdown'
}

local function add_queries()
    local queries = '; inherits: %s\n\n(identifier) @spell'
    local queries_dir = vim.fn.stdpath 'config' .. '/after/queries/'

    for _, lang in ipairs(langs) do
        local path = queries_dir .. lang .. '/highlights.scm'
        local file = io.open(path, 'r')

        if file then
            file:close()
            goto continue
        end

        os.execute('mkdir -p ' .. queries_dir .. lang)

        file = io.open(path, 'w')
        if not file then
            print('Could not extend queries for ' .. lang .. ' file: ' .. path)
            goto continue
        end

        file:write(string.format(queries, lang))
        file:close()
        ::continue::
    end
end

vim.api.nvim_create_autocmd("FileType", {
    -- pattern = { "go", "gomod", "gowork", "gosum" },
    callback = function()
      pcall(vim.treesitter.start)   -- safe call, ignores errors on non-parser filetypes
      -- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      -- vim.wo[0][0].foldmethod = 'expr'
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    config = function()
        require('nvim-treesitter').setup()
        require('nvim-treesitter').install(langs)
        -- install tree-sitter-cli `brew install tree-sitter-cli`
        -- because some retard decided that a core feature needs an external dependency

        -- very dirty and bad hacks to get spellchecks on identifiers
        -- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
        vim.defer_fn(function()
            add_queries()
        end, 0)
    end,
}
