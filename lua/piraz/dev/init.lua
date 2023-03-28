-- Buffer creation see: https://stackoverflow.com/a/75240496
-- Buffer deletion see: https://stackoverflow.com/a/1381652/2887989

local plenary_path = require("plenary.path")
local data = require("piraz.dev.data")

-- print(vim.inspect(data.config))


local M =  {
}


M.user_home = plenary_path.new(vim.fn.environ()['HOME'])

M.user_config_dir = M.user_home:joinpath(".piraz")

M.python_buf_number = -1
M.go_buf_number = -1

M.log = require('plenary.log').new({
    level = "warn",
    plugin = "piraz",
    -- use_console = false,
})

-- from: https://stackoverflow.com/a/7615129/2887989
-- TODO: This feels wrong...
M.split = function(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end

M.buf_is_visible = function(buf)
    -- Get a boolean that tells us if the buffer number is visible anymore.
    --
    -- :help bufwinnr
    buf = buf or "/"
    return vim.api.nvim_call_function("bufwinnr", { buf }) ~= -1
end

-- From: https://codereview.stackexchange.com/a/282183
M.all_listed_buffers = function()
    local bufs = {}
    local count = 1
    for i, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
            bufs[count] = buf
            count = count + 1
        end
    end

    return bufs
end

M.buf_from_name = function(name)
    for _, buf in ipairs(M.all_listed_buffers()) do
        local name_x = M.split(vim.api.nvim_buf_get_name(buf),"--")
        if name_x[#name_x] == name then
            return buf
        end
    end
    return -1
end

M.buf_open = function(name, type)
    -- Get a boolean that tells us if the buffer number is visible anymore.
    --
    -- :help bufwinnr
    local buf = "-1"
    name = name or "MONSTER_OF_THE_LAKE"
    type = type or "txt"

    local buf_from_name = M.buf_from_name(name)
    if buf_from_name ~= -1 then
        return buf_from_name
    end

    local cur_win = vim.api.nvim_get_current_win()
    if buf == -1 or not M.buf_is_visible(buf) then
        vim.cmd("botright vsplit --" .. name)
        buf = vim.api.nvim_get_current_buf()
        vim.opt_local.readonly = true
        vim.api.nvim_buf_set_option(buf, "filetype", type)
        vim.api.nvim_set_current_win(cur_win)
        return buf
    end
end

-- print(M.buf_from_name("MONSTER_OF_THE_LAKE"))
-- print(vim.inspect(M.all_listed_buffers()))

M.buf_clear = function (buf)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
end

M.buf_append = function(buf, lines)
    local line_count = #vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    if line_count < 2 then
        local first_line = vim.api.nvim_buf_get_lines(buf, 0, -1, false)[1]
        if first_line == "" then
            line_count = 0
        end
    end
    vim.api.nvim_buf_set_lines(buf, line_count, -1, false, lines)
end

M.setup = function()
    if vim.fn.environ()['PIRAZ_DEBUG_LEVEL'] then
        M.log = require('plenary.log').new({
            level = vim.fn.environ()['PIRAZ_DEBUG_LEVEL'],
            plugin = "piraz",
            -- use_console = false,
        })
    end

    if vim.fn.environ()['PIRAZ_HOME'] then
        M.log.warn("changing user config home to " ..
            vim.fn.environ()['PIRAZ_HOME'])
    end

    if not  M.user_config_dir:exists() then
        M.log.warn("creating user config dir: " ..
            M.user_config_dir)
        M.user_config_dir:mkdir()
    end
end

-- M.buf_clear(32)
-- M.buf_append(32, {"buga huga"})
-- print(vim.inspect(M.all_listed_buffers()))

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

-- print(vim.inspect(M.split("asdfas/asdf/asdf/asdf/sfd", "/")))
-- print(vim.inspect(M.all_listed_buffers()))
-- print(M.buf_open(M.python_buf_number))

return M
