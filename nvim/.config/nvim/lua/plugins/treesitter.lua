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

return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    config = function()
        require('nvim-treesitter').install(langs)
        -- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
        vim.defer_fn(function()
            add_queries()
        end, 0)
    end,
}
