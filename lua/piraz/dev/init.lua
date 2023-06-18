-- Buffer creation see: https://stackoverflow.com/a/75240496
local Path = require("plenary.path")

local M =  {}

M.sep = Path.path.sep

M.log = require('plenary.log').new({
    level = "info",
    plugin = "piraz",
    -- use_console = false,
})

return M
