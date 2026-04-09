vim.g.zig_fmt_autosave = 0
-- .net bs
vim.g.dotnet_errors_only = true
vim.g.dotnet_show_project_file = false

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
    end,
})

return {
    "seblyng/roslyn.nvim",
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        'mason-org/mason-lspconfig.nvim',
        version = 'v2.x',
        opts = {
            ensure_installed = { 'lua_ls', 'gopls' },
        },
        dependencies = {
            {
                'mason-org/mason.nvim',
                version = 'v2.x',
                opts = {
                    registries = {
                        "github:mason-org/mason-registry",
                        "github:Crashdummyy/mason-registry",
                    },
                }
            },
            'neovim/nvim-lspconfig',
            { 'j-hui/fidget.nvim', opts = {} }, -- lsp status updates
        },
    },
}
