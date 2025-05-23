return {
    -- Git
    {
        "tpope/vim-fugitive",
        config = function ()
            vim.keymap.set("n", "<leader>gg", vim.cmd.Git, {desc = "Run Git command from fugitive"})
            vim.keymap.set("n", "<leader>gc", "<cmd>G commit<CR>", {desc = "Run Git commit from fugitive"})
            vim.keymap.set("n", "<leader>gl", "<cmd>G log<CR>", {desc = "Run Git log from fugitive"})
            vim.keymap.set("n", "<leader>gpl", "<cmd>G pull<CR>", {desc = "Run Git pull from fugitive"})
            vim.keymap.set("n", "<leader>gps", "<cmd>G push<CR>", {desc = "Run Git push from fugitive"})
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add          = { text = "+" },
                change       = { text = "~" },
                delete       = { text = "-" },
                topdelete    = { text = "‾" },
                changedelete = { text = "≃" },
                untracked    = { text = "┆" },
            },
            signs_staged = {
                add          = { text = "+" },
                change       = { text = "~" },
                delete       = { text = "-" },
                topdelete    = { text = "‾" },
                changedelete = { text = "≃" },
                untracked    = { text = "┆" },
            },
            signs_staged_enable = true,
            signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
            numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
            linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {
                follow_files = true
            },
            auto_attach = true,
            attach_to_untracked = true,
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                -- "eol" | "overlay" | "right_align"
                virt_text_pos = "eol",
                delay = 500,
                ignore_whitespase = false,
                virt_text_priority = 100,
                use_focus = true,
            },
            current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
            sign_priority = 6,
            update_debounce = 100,
            -- Use default
            status_formatter = nil,
            -- Disable if file is longer than this (in lines)
            max_file_length = 40000,
            preview_config = {
                -- Options passed to nvim_open_win
                border = "single",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1
            },
            on_attach = function (bufnr) -- if needed use bufnr
                -- vim.keymap.set("n", "<leader>gd", function() vim.cmd("GitGutterDisable") end)
                -- vim.keymap.set("n", "<leader>ge", function() vim.cmd("GitGutterEnable") end)
                -- vim.keymap.set("n", "<leader>gf", "<Plug>(GitGutterFold)")
                vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<CR>")
                vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<CR>")

                -- Hunk actions
                vim.keymap.set("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>")
                vim.keymap.set("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>")
                vim.keymap.set("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>")
                vim.keymap.set("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>")
                -- vim.keymap.set("x", "<leader>gs", "<Plug>(GitGutterStageHunk)")
                vim.keymap.set("n", "<leader>gtb", "<cmd>Gitsigns toggle_current_line_blame<CR>")
                vim.keymap.set("n", "<leader>gtd", "<cmd>Gitsigns toggle_deleted<CR>")
                vim.keymap.set("n", "<leader>gtl", "<cmd>Gitsigns toggle_linehl<CR>")
                vim.keymap.set("n", "<leader>gtn", "<cmd>Gitsigns toggle_numhl<CR>")
                vim.keymap.set("n", "<leader>gts", "<cmd>Gitsigns toggle_signs<CR>")
                vim.keymap.set("n", "<leader>gtw", "<cmd>Gitsigns toggle_word_diff<CR>")
                -- FIXES: Gitsigns attaches to netrw buffers (inconsistent)
                -- See: https://github.com/lewis6991/gitsigns.nvim/issues/1318#issuecomment-2878738359
                if vim.bo[bufnr].filetype == "netrw" then return false end
            end
        }
    },
}
