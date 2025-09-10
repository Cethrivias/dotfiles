vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        local bufnr = args.buf
        if client:supports_method 'textDocument/implementation' then
            -- Create a keymap for vim.lsp.buf.implementation ...
        end

        local nmap = function(keys, func, desc)
            if desc then
                desc = 'LSP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        local tb = require 'telescope.builtin'
        local t_configure = function(telescope_builtin_func)
            local theme = require('telescope.themes').get_ivy {
                fname_width = 50,
                symbol_width = 30,
                show_line = false,
            }
            return function()
                telescope_builtin_func(theme)
            end
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('gr', t_configure(tb.lsp_references), '[G]oto [R]eferences')
        nmap('gi', t_configure(tb.lsp_implementations), '[G]oto [I]mplementation')
        nmap('<leader>ds', t_configure(tb.lsp_document_symbols), '[D]ocument [S]ymbols')
        nmap('<leader>ws', t_configure(tb.lsp_dynamic_workspace_symbols), '[W]orkspace [S]ymbols')
        nmap('<leader>f', vim.lsp.buf.format, '[F]ormat')
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })

        if client.name == 'omnisharp' then
            print 'loading csharp custom mappings'
            local cs = require 'omnisharp_extended'
            nmap('gr', t_configure(cs.telescope_lsp_references), '(CS) [G]oto [R]eferences')
            nmap('gd', t_configure(cs.telescope_lsp_definition), '(CS) [G]oto [D]efinition')
            nmap('gi', t_configure(cs.telescope_lsp_implementation), '(CS) [G]oto [I]mplementation')
        else
            -- nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
            nmap('gd', t_configure(tb.lsp_definitions), '[G]oto [D]efinition')
        end

        -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
        -- if client:supports_method 'textDocument/completion' then
        --     -- Optional: trigger autocompletion on EVERY keypress. May be slow!
        --     -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
        --     -- client.server_capabilities.completionProvider.triggerCharacters = chars
        --
        --     vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        -- end

        -- Auto-format ("lint") on save.
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        if
            not client:supports_method 'textDocument/willSaveWaitUntil'
            and client:supports_method 'textDocument/formatting'
        then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format { bufnr = args.buf, id = client.id, timeout_ms = 1000 }
                end,
            })
        end
    end,
})

return {
    { 'Hoffs/omnisharp-extended-lsp.nvim' },
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
        end,
    },
}
