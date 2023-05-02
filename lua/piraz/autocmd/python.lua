-- see:help events
-- au BufWritePost  <=== To display the autocmds
-- au! BufWritePost <=== To clear
-- SEE: https://youtu.be/HR1dKKrOmDs?t=324
-- SEE: https://youtu.be/9gUatBHuXE0?t=453 <== Jobstart
-- SEE: https://stackoverflow.com/a/75240496

local Dev = require("piraz.dev")
local Log = Dev.log
local plenary_path = require("plenary.path")

local M = {}

M.group = vim.api.nvim_create_augroup("PirazPy", { clear = true })

M.buf_name_prefix = "PirazPy: "

M.buf_name_suffix = " P)"

M.setup_called = false
M.vim_did_enter = false

-- Output buffers table
M.bufs_out = {}

-- print(M.bufs_out)

M.buf_is_main = function(buf_number)
    local lines = vim.api.nvim_buf_get_lines(buf_number, 0, -1, false)
    for _, line in ipairs(lines) do
        local pattern = "if __name__[ ]*==[ ]*[\"|']__main__[\"|'][ ]*:"
        if string.match(line, pattern) then
            return true
        end
    end
M.vim_did_enter = false
    return false
end

-- M.buf_out_register(file, name, python

M.on_python_save = function()
    local data = {
        buf = tonumber(vim.fn.expand("<abuf>")),
        file = vim.fn.expand("<afile>"),
        match = vim.fn.expand("<amatch>"),
    }
    if M.buf_is_main(data.buf) then
        Log.info("Doing main stuff...")
        -- print(vim.inspect(data))
        Dev.buf_open(data.file .. "_run")
    end
    -- print(vim.inspect(data))
    -- vim.api.nvim_create_buf(false, false)
end

function M.is_python_project()
    -- TODO: Finish to check other python project possibilities
    if Dev.project_root:joinpath("setup.py"):exists() then
        return true
    end
    return false
end

function M.setup_project_virtualenv()
    if M.setup_called then
        if M.is_python_project() then
            local cwd_x = vim.fn.split(vim.fn.getcwd(), Dev.sep)
            Dev.setup_virtualenv(cwd_x[#cwd_x], M.set_python)
        end
    end
end

function M.on_vim_start()
    M.setup_project_virtualenv()
end

vim.api.nvim_create_autocmd("VimEnter", {
    callback = M.on_vim_start,
    group = M.group,
})

M.setup = function()
    M.setup_called = true

    if Dev.vim_did_enter then
        M.setup_project_virtualenv()
    end

    vim.api.nvim_create_autocmd("BufWritePost", {
        callback = M.on_python_save,
        pattern = "*.py",
        group = M.group,
    })
end

function M.set_python(venv_path)
    local venv_bin = venv_path:joinpath("bin")
    -- local venv_activate = venv_bin:joinpath("activate")
    Dev.add_to_path(venv_bin)
    -- let $VIRTUAL_ENV=<project_virtualenv>
    vim.cmd("let $VIRTUAL_ENV='" .. venv_path.filename .. "'")
    vim.cmd("let $PYTHONPATH='.:" .. Dev.project_root.filename .. "'")
end

return M
