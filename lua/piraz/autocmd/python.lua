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
    local project_root = vim.fn.getcwd()
    if plenary_path.new(project_root, "setup.py"):exists() then
        return true
    end
    return false
end

function M.on_vim_start()
    if M.setup_called then
        if M.is_python_project() then
            Dev.setup_virtualenv()
        end
    end
end

vim.api.nvim_create_autocmd("VimEnter", {
    callback = M.on_vim_start,
    group = M.group,
})

M.setup = function()
    if Dev.vim_did_enter then
        M.setup_virtualenv()
    end

    M.setup_called = true

    vim.api.nvim_create_autocmd("BufWritePost", {
        callback = M.on_python_save,
        pattern = "*.py",
        group = M.group,
    })
end

return M
