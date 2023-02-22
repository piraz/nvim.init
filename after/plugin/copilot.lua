-- vim.api.nvim_set_keymap("i", "<leader>ca", "copilot#Accept('<CR>')", {expr=true, silent=true})
vim.keymap.set("n", "<leader>cod", function() vim.cmd("Copilot disable") end)
vim.keymap.set("n", "<leader>coe", function() vim.cmd("Copilot enable") end)
vim.keymap.set("n", "<leader>cos", function() vim.cmd("Copilot status") end)

vim.cmd("Copilot disable")

