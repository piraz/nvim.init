local dev = require("piraz.dev")
local log = dev.log

local loaded, indent_blankline = pcall(require, "indent_blankline")
if not loaded then
    log.debug("ident blankline not found")
    return
end

indent_blankline.setup {
    -- for exampile, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = false,
}

vim.cmd("IndentBlanklineDisable")

vim.keymap.set("n", "<leader>ii", "<cmd>IndentBlanklineToggle<CR>")
