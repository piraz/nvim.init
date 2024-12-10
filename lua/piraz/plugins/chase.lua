-- This file can be loaded by calling `lua require("plugins")` from your
-- init.vim
local Dev = require("piraz.dev")

local chase_source = table.concat({
    Dev.USER_HOME, "source", "candango", "chase"
}, Dev.sep)

local chase = { "candango/chase.nvim", opts={} }
if Dev.path_exists(chase_source) then
    chase = { "candango/chase.nvim", dev = true, name = "chase", opts={} }
end

return {
    chase
}
