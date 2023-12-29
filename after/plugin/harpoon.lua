local dev = require("piraz.dev")
local log = dev.log

local loaded, harpoon = pcall(require, "harpoon")
if not loaded then
    if log then
        log.debug("harpoon not found")
    end
    return
end

harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
vim.keymap.set("n", "<C-h>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end)
vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
