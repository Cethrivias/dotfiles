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
}

local function add_queries()
    local queries = '; inherits: %s\n\n(identifier) @spell'
    local queries_dir = vim.fn.stdpath('config') .. '/after/queries/'

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
    config = function()
        -- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
        vim.defer_fn(function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = langs,
                auto_install = false,
                sync_install = false,

                ignore_install = {},
                modules = {},

                highlight = { enable = true },
                indent = { enable = true },

                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<c-space>',
                        node_incremental = '<c-space>',
                        scope_incremental = '<c-s>',
                        node_decremental = '<M-space>',
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ['aa'] = '@parameter.outer',
                            ['ia'] = '@parameter.inner',
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = '@class.outer',
                        },
                        goto_next_end = {
                            [']M'] = '@function.outer',
                            [']['] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer',
                        },
                        goto_previous_end = {
                            ['[M'] = '@function.outer',
                            ['[]'] = '@class.outer',
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ['<leader>a'] = '@parameter.inner',
                        },
                        swap_previous = {
                            ['<leader>A'] = '@parameter.inner',
                        },
                    },
                },
            }
            add_queries()
        end, 0)
    end,
}
