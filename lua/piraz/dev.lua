local M =  {
}

M.log = require("plenary.log").new({
    level = "debug",
    plugin = "piraz",
    use_console = false,
})

-- from: https://stackoverflow.com/a/9102300/2887989
M.get_path = function(file_path, sep)
    sep=sep or "/"
    return file_path:match("(.*"..sep..")")
end

return M
