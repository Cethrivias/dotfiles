vim.api.nvim_create_user_command('Test', function(cmd)
    if cmd.args[0] then
        require("neotest").run.run(cmd.args[0])
    end

    require("neotest").run.run()
end, { desc = 'Run nearest test or using filter' })

vim.api.nvim_create_user_command('TestFile', function()
    require("neotest").run.run(vim.fn.expand("%"))
end, { desc = 'Run all tests in the current file' })

vim.api.nvim_create_user_command('TestOut', function()
    require("neotest").output_panel.open();
end, { desc = 'Show tests output' })

vim.api.nvim_create_user_command('TestSum', function()
    require("neotest").summary.toggle({ enter = true });
end, { desc = 'Toggle tests summary' })

vim.keymap.set(
    'n',
    '<leader>5',
    function()
        require("neotest").summary.toggle({ enter = true });
    end, { desc = 'Toggle tests summary' }
)

return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "romus204/tree-sitter-manager.nvim",
        "citizenharris/neotest-dotnet",
        {
            "fredrikaverpil/neotest-golang",
            version = "*",                                                              -- Optional, but recommended; track releases
            build = function()
                vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait() -- Optional, but recommended
            end,
        },
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-dotnet"),
                require("neotest-golang")({
                    runner = "gotestsum", -- Optional, but recommended
                    go_test_args = { "-count=1", "-tags=unit,integration" },
                    go_list_args = { "-tags=unit,integration" },
                    env = {
                        CGO_ENABLED = "1",
                        DATABASE_URL = "postgresql://root@localhost:26257/wallethub?sslmode=disable",
                    },
                }),
            }
        })
    end
}
