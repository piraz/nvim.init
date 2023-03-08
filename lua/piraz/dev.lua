-- Buffer creation see: https://stackoverflow.com/a/75240496
-- Buffer deletion see: https://stackoverflow.com/a/1381652/2887989

local plenary_path = require("plenary.path")

local M =  {
}

M.user_home = vim.fn.environ()['HOME']

M.python_buf_number = -1
M.go_buf_number = -1

M.log = require('plenary.log').new({
    level = "debug",
    plugin = "piraz",
    use_console = false,
})

M.buf_exists = function(buf_number)
    -- Get a boolean that tells us if the buffer number is visible anymore.
    --
    -- :help bufwinnr
    buf_number = buf_number or "/"
    return vim.api.nvim_call_function("bufwinnr", { buf_number }) ~= -1
end

M.buf_open = function(buf_number, buf_name, buf_type)
    -- Get a boolean that tells us if the buffer number is visible anymore.
    --
    -- :help bufwinnr
    buf_number = buf_number or "-1"
    buf_name = buf_name or "MONSTER_OF_THE_LAKE"
    buf_type = buf_type or "txt"

    if buf_number == -1 or not M.buf_exists(buf_number) then
        vim.cmd("botright vsplit "..buf_name)
        buf_number = vim.api.nvim_get_current_buf()
        vim.opt_local.readonly = true
        vim.api.nvim_buf_set_option(buf_number, "filetype", buf_type)
        return buf_number
    end
end

-- from: https://stackoverflow.com/a/9102300/2887989
M.get_path = function(file_path, sep)
    sep = sep or "/"
    return file_path:match("(.*"..sep..")")
end

M.python_project_root = function()
    local cwd = vim.fn.getcwd()
    -- Solving firenado projects
    -- if path.
    -- print(vim.fn.getcwd())
    print(vim.inspect(plenary_path))
    print("Buga")
end

-- print(M.buf_open(M.python_buf_number))

return M
