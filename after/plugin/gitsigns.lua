local Dev = require("piraz.dev")
local log = Dev.log

local loaded, gitsigns = pcall(require, "gitsigns")
if loaded then
    gitsigns.setup {
        signs = {
            add          = { text = "+" },
            change       = { text = "~" },
            delete       = { text = "-" },
            topdelete    = { text = "‾" },
            changedelete = { text = "~-" },
            untracked    = { text = "┆" },
        },
        signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
            interval = 1000,
            follow_files = true
        },
        attach_to_untracked = true,
        -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame = false,
        current_line_blame_opts = {
            virt_text = true,
            -- 'eol' | 'overlay' | 'right_align'
            virt_text_pos = 'eol',
            delay = 1000,
            ignore_whitespace = false,
        },
        current_line_blame_formatter =
            "<author>, <author_time:%Y-%m-%d> - <summary>",
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
        yadm = {
            enable = false
        },
    }
    -- vim.keymap.set("n", "<leader>gd", function() vim.cmd("GitGutterDisable") end)
    -- vim.keymap.set("n", "<leader>ge", function() vim.cmd("GitGutterEnable") end)
    -- vim.keymap.set("n", "<leader>gf", "<Plug>(GitGutterFold)")
    -- vim.keymap.set("n", "]c", "<Plug>(GitGutterNextHunk)")
    -- vim.keymap.set("n", "[c", "<Plug>(GitGutterPrevHunk)")
    -- vim.keymap.set("n", "<leader>gp", "<Plug>(GitGutterPreviewHunk)")
    -- vim.keymap.set("n", "<leader>gs", "<Plug>(GitGutterStageHunk)")
    -- vim.keymap.set("x", "<leader>gs", "<Plug>(GitGutterStageHunk)")
    -- vim.keymap.set("n", "<leader>gt", function() vim.cmd("GitGutterToggle") end)
    -- vim.keymap.set("n", "<leader>gu", "<Plug>(GitGutterUndoHunk)")
else
    log.debug("gitsigns not found")
end
