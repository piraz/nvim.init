local dev = require("piraz.dev")
local log = dev.log

local loaded, surround = pcall(require, "nvim-surround")
if not loaded then
    log.debug("nvim-surround not found")
    return
end

surround.setup({})
