--- @param buffer integer Buffer id
local csharpier = function(buffer)
    local name = vim.api.nvim_buf_get_name(buffer)
    local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
    local cmd = { 'csharpier', 'format', '--write-stdout' }
    if name ~= "" then
        vim.list_extend(cmd, { '--stdin-path', name })
    end
    local res = vim.system(cmd, { text = true, stdin = lines, timeout = 1000 }):wait()
    if res.code ~= 0 then
        vim.notify('csharpier: ' .. res.stderr, vim.log.levels.ERROR)
        return
    end

    vim.api.nvim_buf_set_lines(buffer, 0, -1, false, vim.split(res.stdout, '\n'))
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        local bufnr = args.buf

        local nmap = function(keys, func, desc)
            if desc then
                desc = 'LSP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        local tb = require 'telescope.builtin'
        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        nmap('gr', tb.lsp_references, '[G]oto [R]eferences')
        -- nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gd', tb.lsp_definitions, '[G]oto [D]efinition')
        nmap('gt', tb.lsp_type_definitions, '[G]oto [T]ype Definitions')
        nmap('gi', tb.lsp_implementations, '[G]oto [I]mplementation')
        nmap('<leader>ds', tb.lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>ws', tb.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        if client.name == 'roslyn' then
            nmap('<leader>f', function() csharpier(bufnr) end, '[F]ormat with CSharpier')
        else
            if client:supports_method 'textDocument/formatting' then
                nmap('<leader>f', function() vim.lsp.buf.format { bufnr = bufnr, id = client.id } end,
                    '[F]ormat current buffer with LSP')
            end

            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, 'Format',
                function() vim.lsp.buf.format { bufnr = bufnr, id = client.id } end,
                { desc = 'Format current buffer with LSP' })
        end

        -- Auto-format ("lint") on save.
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        -- if
        --     not client:supports_method 'textDocument/willSaveWaitUntil'
        --     and client:supports_method 'textDocument/formatting'
        -- then
        --     vim.api.nvim_create_autocmd('BufWritePre', {
        --         group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        --         buffer = bufnr,
        --         callback = function()
        --             vim.lsp.buf.format { bufnr = bufnr, id = client.id, timeout_ms = 1000 }
        --         end,
        --     })
        -- end
    end,
})

return {
    {
        "seblyng/roslyn.nvim",
        ---@module 'roslyn.config'
        ---@type RoslynNvimConfig
        opts = {
            -- your configuration comes here; leave empty for default settings
        },
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'folke/lazydev.nvim',
                ft = 'lua', -- only load on lua files
                opts = {
                    library = {
                        -- Load luvit types when the `vim.uv` word is found
                        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                    },
                },
            }, -- nvim types
            { 'mason-org/mason.nvim',           version = 'v2.x' },
            { 'mason-org/mason-lspconfig.nvim', version = 'v2.x' },
            'j-hui/fidget.nvim', -- lsp status updates
            'saghen/blink.cmp',
        },
        config = function()
            require('fidget').setup {}
            require('mason').setup {
                registries = {
                    "github:mason-org/mason-registry",
                    "github:Crashdummyy/mason-registry",
                },
            }
            require('mason-lspconfig').setup {
                automatic_enable = true,
                ensure_installed = { 'lua_ls', 'gopls' },
                automatic_installation = false,
            }

            -- vim.lsp.enable('roslyn_ls')
            -- vim.lsp.config('roslyn_ls', {
            --     cmd = {
            --         'roslyn',
            --         '--logLevel',          -- this property is required by the server
            --         'Information',
            --         '--extensionLogDirectory', -- this property is required by the server
            --         vim.fs.joinpath(vim.uv.os_tmpdir(), 'roslyn_ls/logs'),
            --         '--stdio',
            --     }
            --     -- [[ filetypes = { 'cs', 'csharp' } ]]
            -- })
        end,
    },
}
