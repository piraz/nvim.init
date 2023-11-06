-- Buffer creation see: https://stackoverflow.com/a/75240496
local Path = require("plenary.path")

local M =  {}

M.OS_NAME = vim.loop.os_uname().sysname
M.USER_HOME = vim.fn.environ()['HOME']

M.sep = Path.path.sep

function M.is_linux ()
    return string.match(M.OS_NAME, "Linux") ~= nil
end

function M.is_mac()
    return string.match(M.OS_NAME, "Darwin") ~= nil
end

M.log = require('plenary.log').new({
    level = "info",
    plugin = "piraz",
    -- use_console = false,
})

return M
