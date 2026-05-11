return {
    {
        "polarmutex/git-worktree.nvim",  version = "^2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        },
        config = function()
            local chase = require("chase")
            local Hooks = require("git-worktree.hooks")
            local update_on_switch = Hooks.builtins.update_current_buffer_on_switch

            -- Isso aqui garante que quando você trocar de worktree,
            -- o Neovim atualize os arquivos abertos pra pasta nova
            Hooks.register(Hooks.type.SWITCH, function (path, prev_path)
                vim.api.nvim_set_current_dir(path)
                vim.notify("Mudando de: " .. prev_path .. " -> " .. path)
                update_on_switch(path, prev_path)
                chase.setup()
            end)

            -- Carrega a extensão no Telescope pra você ter um menu visual
            require('telescope').load_extension('git_worktree')
        end,
        keys = {
            {
                "<leader>gw",
                function() require('telescope').extensions.git_worktree.git_worktree() end, -- REMOVIDO O "S"
                desc = "Listar Worktrees"
            },
            {
                "<leader>gc",
                function() require('telescope').extensions.git_worktree.create_git_worktree() end,
                desc = "Criar Worktree"
            },
        }
    },
}
