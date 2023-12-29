local dev = require("piraz.dev")
local log = dev.log

local loaded, surround = pcall(require, "nvim-surround")
if not loaded then
    if log then
        log.debug("nvim-surround not found")
    end
    return
end

surround.setup({})
