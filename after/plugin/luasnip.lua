local dev = require("piraz.dev")
local log = dev.log

local loaded, loader = pcall(require, "luasnip.loaders.from_vscode")
if not loaded then
    log.debug("luasnip.loaders.from_vscode not found")
    return
end
-- See: https://github.com/rafamadriz/friendly-snippets#with-lazynvim
loader.lazy_load()
