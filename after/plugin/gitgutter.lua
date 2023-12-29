local Dev = require("piraz.dev")
local log = Dev.log

local loaded, _ = pcall(vim.cmd, "GitGutterDisable")
if loaded then
    vim.cmd("GitGutterEnable")
    vim.keymap.set("n", "<leader>gd", function() vim.cmd("GitGutterDisable") end)
    vim.keymap.set("n", "<leader>ge", function() vim.cmd("GitGutterEnable") end)
    vim.keymap.set("n", "<leader>gf", "<Plug>(GitGutterFold)")
    vim.keymap.set("n", "]c", "<Plug>(GitGutterNextHunk)")
    vim.keymap.set("n", "[c", "<Plug>(GitGutterPrevHunk)")
    vim.keymap.set("n", "<leader>gp", "<Plug>(GitGutterPreviewHunk)")
    vim.keymap.set("n", "<leader>gs", "<Plug>(GitGutterStageHunk)")
    vim.keymap.set("x", "<leader>gs", "<Plug>(GitGutterStageHunk)")
    vim.keymap.set("n", "<leader>gt", function() vim.cmd("GitGutterToggle") end)
    vim.keymap.set("n", "<leader>gu", "<Plug>(GitGutterUndoHunk)")
else
    if log then
        log.debug("vim.gitgutter not found")
    end
end
