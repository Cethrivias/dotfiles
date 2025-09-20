return {
    'https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git',
    -- Activate when a file is created/opened
    event = { 'BufReadPre', 'BufNewFile' },
    -- Activate when a supported filetype is open
    ft = { 'csharp', 'go' },
    cond = function()
        -- Only activate if token is present in environment variable.
        -- Remove this line to use the interactive workflow.
        return vim.env.GITLAB_TOKEN ~= nil and vim.env.GITLAB_TOKEN ~= ''
    end,
    opts = {
        statusline = {
            -- overrides whatever status line you currently have
            enabled = false
        },
        code_suggestions = {
            enabled = true,
            -- For the full list of default languages, see the 'auto_filetypes' array in
            -- https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim/-/blob/main/lua/gitlab/config/defaults.lua
            auto_filetypes = { 'csharp', 'go' }, -- Default is { 'ruby' }
            ghost_text = {
                enabled = true,           -- ghost text is an experimental feature
                accept_suggestion = "<C-l>",
                clear_suggestions = "<C-k>",
                stream = true,
            },
        }
    },
}
