local dev = require("piraz.dev")
local log = dev.log

local loaded, ls = pcall(require, "luasnip")
if not loaded then
    if log then
        log.debug("luasnip not found")
    end
    return
end

vim.keymap.set("i", "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end,
    {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end,
    {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})
-- See: https://github.com/rafamadriz/friendly-snippets#with-lazynvim
require("luasnip.loaders.from_vscode").lazy_load()
