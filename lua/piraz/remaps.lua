local keymap = require("piraz.keymap")

local nnoremap = keymap.nnoremap
local vnoremap = keymap.vnoremap

local function run_file()
    local current_file_type = vim.api.nvim_buf_get_option(0, "filetype")
    if current_file_type == "go" then
        vim.cmd("GoRun")
        return
    end
    if current_file_type == "lua" then
        vim.cmd("so")
        return
    end
    if current_file_type == "python" then
        vim.cmd("!python %")
        return
    end
end

vim.g.mapleader = " "
-- nnoremap("<leader>bls", "<cmd>ls<CR><cmd>b ")
nnoremap("<leader>ee", "<cmd>Ex<CR>")
nnoremap("<leader>ls", "<cmd>ls<CR>")
nnoremap("<leader>so", run_file)
nnoremap("<leader>pks", "<cmd>PackerSync<CR>")
nnoremap("<leader>py", ":!python %<CR>")
nnoremap("<leader>w", ":w<CR>")


-- see: https://stackoverflow.com/a/73354675/2887989
nnoremap("<leader>y", [["+y]])
vnoremap("<leader>y", [["+y<Esc>]])
nnoremap("<leader>Y", [["+yy]])
vnoremap("<leader>Y", [["+yy<Esc>]])
-- TODO: Fix the leader+p in normal model, it is wayting too much
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
