local dev = require("piraz.dev")
local log = dev.log

local loaded, gitsigns = pcall(require, "gitsigns")
if not loaded then
    if log then
        log.debug("gitsigns not found")
    end
    return
end

gitsigns.setup {
    signs = {
        add          = { text = "+" },
        change       = { text = "~" },
        delete       = { text = "-" },
        topdelete    = { text = "‾" },
        changedelete = { text = "≃" },
        untracked    = { text = "┆" },
    },
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
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
        virt_text_pos = "eol",
        delay = 500,
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
vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<CR>")
vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<CR>")

-- Hunk actions
vim.keymap.set("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>")
vim.keymap.set("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>")
vim.keymap.set("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>")
vim.keymap.set("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>")
-- vim.keymap.set("x", "<leader>gs", "<Plug>(GitGutterStageHunk)")
vim.keymap.set("n", "<leader>gtb",
    "<cmd>Gitsigns toggle_current_line_blame<CR>")
vim.keymap.set("n", "<leader>gtd", "<cmd>Gitsigns toggle_deleted<CR>")
vim.keymap.set("n", "<leader>gtl", "<cmd>Gitsigns toggle_linehl<CR>")
vim.keymap.set("n", "<leader>gtn", "<cmd>Gitsigns toggle_numhl<CR>")
vim.keymap.set("n", "<leader>gts", "<cmd>Gitsigns toggle_signs<CR>")
vim.keymap.set("n", "<leader>gtw", "<cmd>Gitsigns toggle_word_diff<CR>")
