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

local function is_lua_test()
    local fname = vim.fn.expand("%:p")
    local pattern = "_spec%.lua$"
    if string.match(fname, pattern) then
        return true
    end
    return false
end

local function run_file()
    local current_file_type = vim.api.nvim_buf_get_option(0, "filetype")
    if current_file_type == "go" then
        if is_go_test(0) then
            vim.cmd("GoTestFile")
            return
        end
        vim.cmd("GoRun")
        return
    end
    if current_file_type == "lua" then
        if is_lua_test() then
            vim.cmd("PlenaryBustedFile " .. vim.api.nvim_buf_get_name(0))
            return
        end
        vim.cmd("luafile " .. vim.api.nvim_buf_get_name(0))
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
                '"otry:\\<CR>\\<BS>except Exception as e:\\<CR>pass\\<Esc>kO\\<Esc>"'
            ), "m", true
        )
        return
    end
end

vim.g.mapleader = " "
-- nnoremap("<leader>bls", "<cmd>ls<CR><cmd>b ")
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Delete current buffer" })
vim.keymap.set("n", "<leader>cl" , function() vim.opt.cursorcolumn = not vim.opt.cursorcolumn:get() end, {desc = "Toggle opt cursorcolumn"})
vim.keymap.set("n", "<leader>ee", "<cmd>Ex<CR>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>ls", "<cmd>ls<CR>", { desc = "List buffers" })
vim.keymap.set("n", "<leader>ln" , function() vim.opt.number = not vim.opt.number:get() end, {desc = "Toggle opt number"})
vim.keymap.set("n", "<leader>lr" , function() vim.opt.relativenumber = not vim.opt.relativenumber:get() end, {desc = "Toggle opt relativenumber"})
vim.keymap.set("n", "<leader>so", function() vim.cmd("luafile %") end, {desc = "Souce file"})
vim.keymap.set("n", "<leader>x", run_file, {desc = "Run file"})
vim.keymap.set("n", "<leader>mzu", "<cmd>MasonUpdate<CR>", { desc = "Mason Update" })
vim.keymap.set("n", "<leader>lzs", "<cmd>Lazy sync<CR>", { desc = "Lazy sync" })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>dff", [[0vwh"_d]], { desc = "Delete current line without yanking" })
vim.keymap.set("n", "<leader>dfu", [[0i <esc>vwh"_di<bs><esc>li ]], { desc = "Delete current line without yanking and insert space at the beginning" })
vim.keymap.set("n", "<leader>dfd", [[f vc<CR><esc>]], { desc = "Delete current line without yanking and insert space at the beginning" })
vim.keymap.set("n", "<leader>ie", insert_error, { desc = "Insert error handling code" })
vim.keymap.set("n", "<leader>fl", ":% !fold -s<CR>", { desc = "Fold file" })
vim.keymap.set("n", "<leader>fj", ":% !jq<CR>", { desc = "Format JSON file" })

-- see: https://stackoverflow.com/a/73354675/2887989
vim.keymap.set("n","<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("v","<leader>y", [["+y<Esc>]], { desc = "Yank to system clipboard" })
vim.keymap.set("n","<leader>Y", [["+yy]], { desc = "Yank line to system clipboard" })
vim.keymap.set("v","<leader>Y", [["+yy<Esc>]], { desc = "Yank line to system clipboard" })
vim.keymap.set("n","<leader>p", [["+p]], { desc = "Paste from system clipboard" })
vim.keymap.set("v","<leader>p", [["+p]], { desc = "Paste from system clipboard" })

-- From: https://stacjoverflow.com/a/3638557
vim.keymap.set("n","<leader><leader>d", [["_dd]], { desc = "Delete line without yanking" })
vim.keymap.set("v","<leader><leader>d", [["_dd]], { desc = "Delete line without yanking" })
vim.keymap.set("n","<leader><leader>y", [["ay]], { desc = "Yank to register 'a'" })
vim.keymap.set("v","<leader><leader>y", [["ay]], { desc = "Yank to register 'a'" })
vim.keymap.set("n","<leader><leader>p", [["ap]], { desc = "Paste from register 'a'" })
vim.keymap.set("v","<leader><leader>p", [["ap]], { desc = "Paste from register 'a'" })
vim.keymap.set("n","<leader><leader>d", [["add]], { desc = "Delete line without yanking to register 'a'" })
vim.keymap.set("v","<leader><leader>d", [["add]], { desc = "Delete line without yanking to register 'a'" })

-- see: https://stacjoverflow.com/a/63542511/2887989
-- By the way, to select the word under the cursor: * or g*
vim.keymap.set("n","<leader>g8", "g*")
vim.keymap.set("n","<leader>cs", function() vim.cmd([[let @/ = ""]]) end)

-- From: https://superuser.com/a/310424
