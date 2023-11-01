local dev = require("piraz.dev")
local log = dev.log

local loaded, telescope = pcall(require, "telescope")
if not loaded then
    log.debug("telescope not found")
    return
end

telescope.setup {
    defaults = {
        initial_mode = "normal"
    }
}

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>fc", builtin.colorscheme, {})
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
vim.keymap.set("n", "<leader>fq", builtin.quickfix, {})
vim.keymap.set("n", "<leader>fs", builtin.grep_string, {})

vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
