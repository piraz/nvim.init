-- Buffer creation see: https://stackoverflow.com/a/75240496
local data = require("piraz.dev.data")
local plenary_path = require("plenary.path")

-- print(vim.inspect(data.config))


local M =  {
}

M.sep = plenary_path.path.sep
M.user_home = plenary_path:new(vim.fn.environ()['HOME'])
M.user_config_dir = plenary_path:new(M.user_home, ".piraz")
M.user_config_projects_file = plenary_path:new(M.user_config_dir, "projects")
print(M.user_config_projects_file)

M.vim_did_enter = false

M.python_buf_number = -1
M.go_buf_number = -1

M.log = require('plenary.log').new({
    level = "info",
    plugin = "piraz",
    -- use_console = false,
})

function M.buf_is_visible(buf)
    -- Get a boolean that tells us if the buffer number is visible anymore.
    --
    -- :help bufwinnr
    buf = buf or "/"
    return vim.api.nvim_call_function("bufwinnr", { buf }) ~= -1
end

-- From: https://codereview.stackexchange.com/a/282183
function M.all_listed_buffers()
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

function M.buf_from_name(name)
    for _, buf in ipairs(M.all_listed_buffers()) do
        local name_x = vim.api.nvim_buf_get_name(buf):gsub(
            vim.fn.getcwd() .. "/", ""
        )
        if name_x == name then
            return buf
        end
    end
    return -1
end

function M.buf_open(name, type)
    -- Get a boolean that tells us if the buffer number is visible anymore.
    --
    -- :help bufwinnr
    local buf = -1
    name = name or "MONSTER_OF_THE_LAKE"
    type = type or "txt"

    local buf_from_name = M.buf_from_name(name)
    if buf_from_name ~= -1 then
        return buf_from_name
    end

    local cur_win = vim.api.nvim_get_current_win()
    if buf == -1 or not M.buf_is_visible(buf) then
        vim.cmd("botright vsplit " .. name)
        buf = vim.api.nvim_get_current_buf()
        vim.opt_local.readonly = true
        vim.api.nvim_buf_set_option(buf, "filetype", type)
        vim.api.nvim_set_current_win(cur_win)
        return buf
    end
end

-- print(M.buf_from_name("MONSTER_OF_THE_LAKE"))
-- print(vim.inspect(M.all_listed_buffers()))

function M.buf_clear(buf)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
end

function M.buf_append(buf, lines)
    local line_count = #vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    if line_count < 2 then
        local first_line = vim.api.nvim_buf_get_lines(buf, 0, -1, false)[1]
        if first_line == "" then
            line_count = 0
        end
    end
    vim.api.nvim_buf_set_lines(buf, line_count, -1, false, lines)
end

function M.setup()
    if vim.fn.environ()['PIRAZ_DEBUG_LEVEL'] then
        M.log = require('plenary.log').new({
            level = vim.fn.environ()['PIRAZ_DEBUG_LEVEL'],
            plugin = "piraz",
            -- use_console = false,
        })
    end

    if vim.fn.environ()['PIRAZ_HOME'] then
        M.log.trace("changing user config home to " ..
            vim.fn.environ()['PIRAZ_HOME'])
        M.user_home = plenary_path:new(vim.fn.environ()['PIRAZ_HOME'])
        M.user_config_dir = plenary_path:new(M.user_home, ".piraz")
        M.user_config_projects_file = plenary_path:new(
            M.user_config_dir,
            "projects"
        )
    end

    if not  M.user_config_dir:exists() then
        M.log.warn("creating user config dir: " .. M.user_config_dir)
        M.user_config_dir:mkdir()
    end

    if not  M.user_config_projects_file:exists() then
        M.log.warn("creating user projects file: " ..
            M.user_config_projects_file)
        M.user_config_projects_file:touch()
        local file = io.open(M.user_config_projects_file.filename, "w")
        if file == nil then
            return
        end
        file:write(vim.json.encode(data.config))
        file:close()
    end

    local file = io.open(M.user_config_projects_file.filename, "r")
    if file == nil then
        return
    end
    local config = vim.json.decode(file:read())
    file:close()
    -- print(vim.inspect(config))


end

-- M.buf_clear(32)
-- M.buf_append(32, {"buga huga"})
-- print(vim.inspect(M.all_listed_buffers()))

-- from: https://stackoverflow.com/a/9102300/2887989
function M.get_path(file_path, sep)
    sep = sep or "/"
    return file_path:match("(.*"..sep..")")
end


function M.python_project_root()
    local cwd = vim.fn.getcwd()
    -- Solving firenado projects
    -- if path.
    -- print(vim.fn.getcwd())
    print(vim.inspect(plenary_path))
    print("Buga")
end

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function ()
        M.vim_did_enter = true
    end,
    group = M.group,
})
-- print(vim.inspect(M.split("asdfas/asdf/asdf/asdf/sfd", "/")))
-- print(vim.inspect(M.all_listed_buffers()))
-- print(M.buf_open(M.python_buf_number))

return M
