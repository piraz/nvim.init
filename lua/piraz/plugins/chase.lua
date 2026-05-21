-- This file can be loaded by calling `lua require("plugins")` from your
-- init.vim
local chase_source = vim.fs.joinpath(
    vim.uv.os_homedir(),
    "source",
    "candango",
    "chase"
)

local chase = { "candango/chase.nvim", opts={} }
if vim.uv.fs_stat(chase_source) then
    chase = { "candango/chase.nvim", dev = true, name = "chase", opts={} }
end

return {
    chase
}
