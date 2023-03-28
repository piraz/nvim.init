-- vim.api.nvim_set_keymap("i", "<leader>ca", "copilot#Accept('<CR>')", {expr=true, silent=true})
vim.keymap.set("n", "<leader>cod", "<Cmd>Copilot disable<CR>")
vim.keymap.set("n", "<leader>coe", "<Cmd>Copilot enable<CR>")
vim.keymap.set("n", "<leader>cos", "<Cmd>Copilot status<CR>")

vim.cmd("Copilot disable")

