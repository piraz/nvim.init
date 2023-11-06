-- vim.api.nvim_set_keymap("i", "<leader>ca", "copilot#Accept('<CR>')",
-- {expr=true, silent=true})
local loaded, _ = pcall(vim.api.nvim_exec2, "Copilot status", {output=true})

if loaded then
    vim.keymap.set("n", "<leader>cod", "<Cmd>Copilot disable<CR>")
    vim.keymap.set("n", "<leader>coe", "<Cmd>Copilot enable<CR>")
    vim.keymap.set("n", "<leader>cos", "<Cmd>Copilot status<CR>")
end
