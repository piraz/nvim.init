local dev = require("piraz.dev")
local log = dev.log

local loaded, lualine = pcall(require, "lualine")
if not loaded then
    log.debug("lualine not found")
    return
end

local theme = require("lualine.themes.onedark")

lualine.setup {
    options = {
        theme = theme,
    },
}
