-- Buffer creation see: https://stackoverflow.com/a/75240496
local loaded, Log = pcall(require, "plenary.log")

local M =  {}

M.OS_NAME = vim.loop.os_uname().sysname
M.USER_HOME = vim.fn.environ()['HOME']

function M.is_linux()
    return string.match(M.OS_NAME, "Linux") ~= nil
end

function M.is_mac()
    return string.match(M.OS_NAME, "Darwin") ~= nil
end

function M.is_windows()
    return string.match(M.OS_NAME, "Windows") ~= nil
end

function M.path_exists(path)
    local file = io.open(path, "r")
    if (file ~= nil) then
        io.close(file)
        return true
    end
    return false
end

M.sep = "/"

if M.is_windows() then
    M.USER_HOME = os.getenv("UserProfile")
	M.sep = "\\"
end

print(M.USER_HOME)

M.log = nil

if loaded then
	M.log = Log.new({
		level = "info",
		plugin = "piraz",
		-- use_console = false,
	})
end

return M
