-- see:help events
-- au BufWritePost  <=== To display the autocmds
-- au! BufWritePost <=== To clear
-- SEE: https://youtu.be/HR1dKKrOmDs?t=324
-- SEE: https://youtu.be/9gUatBHuXE0?t=453 <== Jobstart
-- SEE: https://stackoverflow.com/a/75240496

local dev = require("piraz.dev")
local log = dev.log

local M = {}

M.group = vim.api.nvim_create_augroup("PirazPy", { clear = true })

M.buf_name_prefix = "PirazPy: "

M.buf_name_suffix = " P)"

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
        log.info("Doing main stuff...")
        -- print(vim.inspect(data))
        dev.buf_open(data.file .. "_run")
    end
    -- print(vim.inspect(data))
    -- vim.api.nvim_create_buf(false, false)
end

M.setup = function()
    vim.api.nvim_create_autocmd("BufWritePost", {
        callback = M.on_python_save,
        pattern = "*.py",
        group = M.group,
    })
end

return M
