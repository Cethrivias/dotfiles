--  This function gets run when an LSP connects to a particular buffer.lspc
local on_attach = function(client, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
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
    nmap('<leader>D', t_configure(tb.lsp_type_definitions), 'Type [D]efinition')
    nmap('<leader>ds', t_configure(tb.lsp_document_symbols), '[D]ocument [S]ymbols')
    nmap('<leader>ws', t_configure(tb.lsp_dynamic_workspace_symbols), '[W]orkspace [S]ymbols')
    nmap('<leader>f', vim.lsp.buf.format, '[F]ormat')
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation') conflicts with tmux-navigator
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    if client.name == 'omnisharp' then
        print 'loading csharp custom mappings'
        -- nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        local cs = require('omnisharp_extended')
        nmap('gr', t_configure(cs.telescope_lsp_references), '(CS) [G]oto [R]eferences')
        nmap('gd', t_configure(cs.telescope_lsp_definition), '(CS) [G]oto [D]efinition')
        nmap('<leader>D', t_configure(cs.telescope_lsp_type_definition), '(CS) Type [D]efinition')
        nmap('gi', t_configure(cs.telescope_lsp_implementation), '(CS) [G]oto [I]mplementation')
    else
        nmap('gd', t_configure(tb.lsp_definitions), '[G]oto [D]efinition')

        if client.supports_method 'textDocument/formatting' then
            vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format { bufnr = bufnr, id = client.id }
                end,
            })
        end
    end
end

local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    -- html = { filetypes = { 'html', 'twig', 'hbs'} },

    templ = { autostart = false },
    tailwindcss = { autostart = false },
    lua_ls = {
        settings = {
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
                -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                -- diagnostics = { disable = { 'missing-fields' } },
            },
        },
    },
    denols = {
        -- root_dir = function()
        --     return require('lspconfig').util.root_pattern('deno.json', 'deno.jsonc')
        -- end,
    },
    tsserver = {
        root_dir = function()
            return require('lspconfig').util.root_pattern 'package.json'
        end,
        single_file_support = false,
    },
    omnisharp = {
        settings = {
            -- All settings: https://github.com/OmniSharp/omnisharp-roslyn/wiki/Configuration-Options
            FormattingOptions = {
                EnableEditorConfigSupport = true,
                OrganizeImports = true,
            },
            MsBuild = {
                loadProjectsOnDemand = nil,
            },
            RoslynExtensionsOptions = {
                enableDecompilationSupport = true,
                enableImportCompletion = true,
                enableAnalyzersSupport = true,
                AnalyzeOpenDocumentsOnly = true
            },
        }
    }
}

return {
    { 'Hoffs/omnisharp-extended-lsp.nvim' },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'folke/lazydev.nvim',
                ft = 'lua', -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                    },
                },
            }, -- nvim types
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'j-hui/fidget.nvim', -- lsp status updates
            'saghen/blink.cmp',
        },
        config = function()
            require('fidget').setup {}
            -- local capabilities = vim.lsp.protocol.make_client_capabilities()
            -- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            require('mason').setup()
            require('mason-lspconfig').setup {
                ensure_installed = { 'lua_ls', 'gopls' },
                automatic_installation = false,
            }
            require('mason-lspconfig').setup_handlers {
                function(server_name)
                    local root_dir
                    local autostart = true
                    local server = servers[server_name] or {}

                    if server.root_dir ~= nil then
                        root_dir = servers[server_name].root_dir()
                    end

                    if server.autostart ~= nil then
                        autostart = servers[server_name].autostart
                    end
                    require('lspconfig')[server_name].setup {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        root_dir = root_dir,
                        autostart = autostart,
                        settings = server.settings,
                        filetypes = server.filetypes,
                    }
                end,
            }
        end,
    },
}
