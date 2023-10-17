local dev = require("piraz.dev")
local log = dev.log

local loaded, indent_blankline = pcall(require, "ibl")
if not loaded then
    log.debug("ident blankline not found")
    return
end

indent_blankline.setup()

vim.cmd("IBLDisable")

vim.keymap.set("n", "<leader>ii", "<cmd>IBLToggle<CR>")
