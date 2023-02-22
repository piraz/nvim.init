local Dev = require("piraz.dev")
local log = Dev.log

local loaded, lualine = pcall(require, "lualine")

if loaded then
    local theme = require("lualine.themes.onedark")
    lualine.setup {
        options = {
            theme = theme,
        },
    }
else
    log.debug("lualine not found")
end
