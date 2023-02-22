local Dev = require("piraz.dev")
local log = Dev.log

local loaded, _ = pcall(vim.cmd, "GitGutterDisable")
if loaded then
    vim.cmd("GitGutterEnable")
    vim.keymap.set("n", "<leader>ggp", "<Plug>(GitGutterPreviewHunk)")
    vim.keymap.set("n", "<leader>ggs", "<Plug>(GitGutterStageHunk)")
    vim.keymap.set("x", "<leader>ggs", "<Plug>(GitGutterStageHunk)")
    vim.keymap.set("n", "<leader>ggu", "<Plug>(GitGutterUndoHunk)")
    vim.keymap.set("n", "<leader>ggf", "<Plug>(GitGutterFold)")
else
    log.debug("vim.gitgutter not found")
end
