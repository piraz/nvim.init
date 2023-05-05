-- Buffer creation see: https://stackoverflow.com/a/75240496
local Data = require("piraz.dev.data")
local plenary_path = require("plenary.path")

-- print(vim.inspect(data.config))


local M =  {}

M.sep = plenary_path.path.sep
M.user_home = plenary_path:new(vim.fn.environ()['HOME'])
M.user_config_dir = plenary_path:new(M.user_home, ".piraz")
M.user_config_projects_file = plenary_path:new(M.user_config_dir, "projects")
M.project_root = plenary_path:new(vim.fn.getcwd())


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
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
            bufs[count] = buf
            count = count + 1
        end
    end

    return bufs
end

function M.buf_from_name(name)
    for _, buf in ipairs(M.all_listed_buffers()) do
        local listed_name = vim.api.nvim_buf_get_name(buf):gsub(
            M.project_root .. M.sep, ""
        )
        if listed_name == name then
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
        -- vim.opt_local.readonly = true
        vim.api.nvim_buf_set_option(buf, "readonly", true)
        vim.api.nvim_buf_set_option(buf, "filetype", type)
        vim.api.nvim_set_current_win(cur_win)
        return buf
    end
end

-- print(M.buf_from_name("MONSTER_OF_THE_LAKE"))
-- print(vim.inspect(M.all_listed_buffers()))

function M.buf_clear(buf)
    vim.api.nvim_buf_set_option(buf, "readonly", false)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
    vim.api.nvim_buf_set_option(buf, "readonly", true)
end

function M.buf_append(buf, lines)
    vim.api.nvim_buf_set_option(buf, "readonly", false)
    local line_count = #vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    if line_count < 2 then
        local first_line = vim.api.nvim_buf_get_lines(buf, 0, -1, false)[1]
        if first_line == "" then
            line_count = 0
        end
    end
    vim.api.nvim_buf_set_lines(buf, line_count, -1, false, lines)
    vim.api.nvim_buf_set_option(buf, "readonly", true)
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
        M.log.warn("creating user config dir: " .. M.user_config_dir.filename)
        M.user_config_dir:mkdir()
    end

    if not  M.user_config_projects_file:exists() then
        M.log.warn("creating user projects file: " ..
            M.user_config_projects_file.filename)
        M.user_config_projects_file:touch()
        local file = io.open(M.user_config_projects_file.filename, "w")
        if file == nil then
            return
        end
        file:write(vim.json.encode(Data.config))
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

function M.setup_virtualenv(venv_prefix, callback)
    local cwd_x = vim.fn.split(vim.fn.getcwd(), M.sep)
    venv_prefix = venv_prefix or cwd_x[#cwd_x]
    local venv_name = venv_prefix .. "_env"
    local venv_root = plenary_path:new(M.user_home, "venvs")
    local venv_path = plenary_path:new(venv_root, venv_name)

    if not venv_path:exists() then
        M.log.warn("virtualenv for " .. venv_prefix .. " doesn't exists")
        M.log.warn("creating virtualenv for " .. venv_prefix)
        vim.fn.jobstart(
        {
            "python",  "-m", "venv", "--clear",
            "--upgrade-deps", venv_path.filename,
        },
        {
            stdout_buffered = true,
            on_stdout = function(_, _)
                M.log.warn("virtualenv " .. venv_prefix ..
                " created successfully")
                if callback ~= nil then
                    callback(venv_path)
                end
            end,
        })
        return
    end
    if callback ~= nil then
        callback(venv_path)
    end
    -- TODO: Seput project virutalenv into the nvim
    -- let $VIRTUAL_ENV=<project_virtualenv>
    -- vim.cmd("let $VIRTUAL_ENV='<project_virtualenv>'")
    -- let $PATH = <project_virtualenv_bin>:$PATH
    -- vim.cmd("let $PATH = <project_virtualenv_bin>:$PATH")
end

function M.add_to_path(path)
    local env_path = vim.fn.environ()["PATH"]
    vim.cmd("let $PATH = '" .. path .. ":" .. env_path .. "'")
end

function M.set_python_global(venv_path)
    local venv_bin = venv_path:joinpath("bin")
    local venv_host_prog = venv_bin:joinpath("python")
    -- local venv_activate = venv_bin:joinpath("activate")
    M.add_to_path(venv_bin)
    vim.cmd("let g:python3_host_prog='" .. venv_host_prog .. "'")
    vim.fn.jobstart(
    { "pip", "show", "pynvim" },
    {
        stderr_buffered = true,
        on_stderr = function(_, data)
            if #data > 1 then
                M.log.warn(
                "installing pynvim at venv " .. venv_path.filename
                )
                M.install_pynvim(venv_path)
            end
            -- M.log.warn("virtualenv " .. venv_prefix .. " created")
        end,
    })
end

function M.install_pynvim(venv_path)
    vim.fn.jobstart(
    { "pip", "install", "pynvim" },
    {
        stdout_buffered = true,
        on_stdout = function(_,_)
            M.log.warn(
            "pynvim installed at " .. venv_path.filename ..
            " successfully"
            )
        end,
    })
end

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function ()
        M.vim_did_enter = true
        M.setup_virtualenv("piraz_global", M.set_python_global)
    end,
    group = M.group,
})
-- print(vim.inspect(M.split("asdfas/asdf/asdf/asdf/sfd", "/")))
-- print(vim.inspect(M.all_listed_buffers()))
-- print(M.buf_open(M.python_buf_number))

return M
