return {
    {
        "polarmutex/git-worktree.nvim",  version = "^2",
        event = "VimEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        },
        config = function()
            local chase = require("chase")
            local Hooks = require("git-worktree.hooks")
            local update_on_switch = Hooks.builtins.update_current_buffer_on_switch

            local function last_worktree_file()
                local git_root = vim.fn.systemlist("git rev-parse --git-common-dir")[1]
                local current = vim.fn.fnamemodify(git_root, ":h:t")
                local parent = vim.fn.fnamemodify(git_root, ":h:h:t")
                local dir = vim.fn.stdpath("data") .. "/worktrees/" .. parent .. "_" .. current
                vim.fn.mkdir(dir, "p")
                return dir .. "/last_worktree"
            end

            local function save_last_worktree(path)
                local f = io.open(last_worktree_file(), "w")
                if f then
                    f:write(path)
                    f:close()
                end
            end

            local function restore_last_worktree()
                local f = io.open(last_worktree_file(), "r")
                if not f then return end
                local path = vim.trim(f:read("*a"))
                f:close()
                if path and path ~= "" and vim.fn.isdirectory(path) == 1 then
                    vim.api.nvim_set_current_dir(path)
                    chase.setup()
                    vim.schedule(function()
                        vim.cmd("Ex " .. vim.fn.fnameescape(path))
                    end)
                end
            end

            Hooks.register(Hooks.type.SWITCH, function(path, prev_path)
                vim.api.nvim_set_current_dir(path)
                vim.notify("Switching from: " .. prev_path .. " -> " .. path)
                update_on_switch(path, prev_path)
                save_last_worktree(path)
                chase.setup()
            end)

            restore_last_worktree()
            require('telescope').load_extension('git_worktree')
        end,
        keys = {
            {
                "<leader>gw",
                function() require('telescope').extensions.git_worktree.git_worktree() end,
                desc = "List worktrees"
            },
            {
                "<leader>gc",
                function() require('telescope').extensions.git_worktree.create_git_worktree() end,
                desc = "Create worktree"
            },
        }
    },
}
