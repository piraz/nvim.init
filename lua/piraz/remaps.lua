local Dev = require("piraz.dev")
local log = Dev.log
local keymap = require("piraz.keymap")

local nnoremap = keymap.nnoremap
local vnoremap = keymap.vnoremap

local function is_go_test(buf_number)
    local lines = vim.api.nvim_buf_get_lines(buf_number, 0, -1, false)
    for _, line in ipairs(lines) do
        local pattern = "func Test[%w]*[ ]*[\\(][ ]*[%w]*[ ]*[\\*][%w]*.T"
        if string.match(line, pattern) then
            return true
        end
    end
    return false
end

local function run_file()
    local current_file_type = vim.api.nvim_buf_get_option(0, "filetype")
    local file_name = vim.api.nvim_buf_get_name(0)
    if current_file_type == "go" then
        if is_go_test(0) then
            vim.cmd("GoTestFile")
            return
        end
        vim.cmd("GoRun")
        return
    end
    if current_file_type == "lua" then
        vim.cmd("so %")
        return
    end
end

local function insert_error()
    local current_file_type = vim.api.nvim_buf_get_option(0, "filetype")
    if current_file_type == "go" then
        vim.api.nvim_feedkeys(
            vim.api.nvim_eval(
                '"oif err != nil {\\<CR>}\\<Esc>Oreturn err\\<Esc>"'
            ), "m", true
        )
        return
    end
    if current_file_type == "python" then
        vim.api.nvim_feedkeys(
            vim.api.nvim_eval(
                '"otry:\\<CR>except e:\\<CR>\\<Tab>pass\\<Esc>kO\\<Tab>\\<Esc>"'
            ), "m", true
        )
        return
    end
end

vim.g.mapleader = " "
-- nnoremap("<leader>bls", "<cmd>ls<CR><cmd>b ")
nnoremap("<leader>bd", ":bd<CR>")
nnoremap("<leader>ee", "<cmd>Ex<CR>")
nnoremap("<leader>ls", "<cmd>ls<CR>")
nnoremap("<leader>so", run_file)
nnoremap("<leader>lzs", "<cmd>Lazy sync<CR>")
nnoremap("<leader>w", ":w<CR>")
nnoremap("<leader>dff", [[0vwh"_d]])
nnoremap("<leader>dfu", [[0vwh"_di<bs><esc>li]])
nnoremap("<leader>dfd", [[f vc<CR><esc>]])
nnoremap("<leader>ie", insert_error)

-- see: https://stackoverflow.com/a/73354675/2887989
nnoremap("<leader>y", [["+y]])
vnoremap("<leader>y", [["+y<Esc>]])
nnoremap("<leader>Y", [["+yy]])
vnoremap("<leader>Y", [["+yy<Esc>]])
nnoremap("<leader>p", [["+p]])
vnoremap("<leader>p", [["+p]])

-- From: https://stackoverflow.com/a/3638557
nnoremap("<leader><leader>d", [["_dd]])
vnoremap("<leader><leader>d", [["_dd]])
nnoremap("<leader><leader>y", [["ay]])
vnoremap("<leader><leader>y", [["ay]])
nnoremap("<leader><leader>p", [["ap]])
vnoremap("<leader><leader>p", [["ap]])
nnoremap("<leader><leader>d", [["add]])
vnoremap("<leader><leader>d", [["add]])

-- see: https://stackoverflow.com/a/63542511/2887989
-- By the way, to select the word under the cursor: * or g*
nnoremap("<leader>g8", "g*")
nnoremap("<leader>cs", function() vim.cmd([[let @/ = ""]]) end)

-- From: https://superuser.com/a/310424
-- TODO: See if this good: nnoremap()
